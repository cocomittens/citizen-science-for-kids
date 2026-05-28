import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import Header from '../../components/Header'
import { apiUrl } from '../../api'
import './Results.css'

type Field = { id: string; label: string; field_type: string }
type ObservationValue = { field_id: string; value: string }
type Observation = {
  id: string
  student_name?: string
  observed_at: string
  values: ObservationValue[]
}

function Results() {
  const { id } = useParams<{ id: string }>()
  const [fields, setFields] = useState<Field[]>([])
  const [observations, setObservations] = useState<Observation[]>([])
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const load = async () => {
      try {
        const token = localStorage.getItem('token')
        const headers = { Authorization: `Bearer ${token}` }
        const [fieldsRes, obsRes] = await Promise.all([
          fetch(apiUrl(`/api/projects/${id}/fields`), { headers }),
          fetch(apiUrl(`/api/projects/${id}/observations`), { headers }),
        ])
        if (!fieldsRes.ok || !obsRes.ok) {
          setError('Failed to load results')
          return
        }
        setFields(await fieldsRes.json())
        setObservations(await obsRes.json())
      } catch {
        setError('Network error')
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [id])

  const labelFor = (fid: string) => fields.find((f) => f.id === fid)?.label ?? fid

  const exportCsv = () => {
    const escape = (v: string) => `"${v.replace(/"/g, '""')}"`
    const header = ['Student', 'Submitted at', ...fields.map((f) => f.label)]
    const rows = observations.map((obs) => {
      const values = new Map(obs.values.map((v) => [v.field_id, v.value]))
      return [
        obs.student_name ?? 'Anonymous',
        new Date(obs.observed_at).toISOString(),
        ...fields.map((f) => values.get(f.id) ?? ''),
      ]
    })
    const csv = [header, ...rows].map((r) => r.map(escape).join(',')).join('\n')
    const url = URL.createObjectURL(new Blob([csv], { type: 'text/csv' }))
    const a = document.createElement('a')
    a.href = url
    a.download = 'observations.csv'
    a.click()
    URL.revokeObjectURL(url)
  }

  return (
    <>
    <Header />
    <div className="projects-page">
      <header>
        <div>
          <h1>Results</h1>
          <p>
            {observations.length} submissions
            {observations.length > 0 &&
              ` · latest ${new Date(observations[0].observed_at).toLocaleString()}`}
          </p>
        </div>
        <div>
          <button type="button" onClick={exportCsv} disabled={observations.length === 0}>
            Export CSV
          </button>
          <Link to="/projects">← Back to projects</Link>
        </div>
      </header>

      {error && <p>{error}</p>}
      {loading ? (
        <p>Loading…</p>
      ) : observations.length === 0 ? (
        <p>No observations yet.</p>
      ) : (
        observations.map((obs) => (
          <div key={obs.id} className="observation">
            <p>
              <strong>{obs.student_name ?? 'Anonymous'}</strong> —{' '}
              {new Date(obs.observed_at).toLocaleString()}
            </p>
            {obs.values.map((v) => (
              <p key={v.field_id}>
                {labelFor(v.field_id)}: {v.value}
              </p>
            ))}
          </div>
        ))
      )}
    </div>
    </>
  )
}

export default Results
