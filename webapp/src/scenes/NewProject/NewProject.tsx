import { useState } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import Header from '../../components/Header'
import './NewProject.css'

const FIELD_TYPES = ['text', 'number', 'checkbox', 'dropdown', 'textarea'] as const

type FieldType = (typeof FIELD_TYPES)[number]

type FieldDraft = {
  label: string
  field_type: FieldType
  options: string
}

function NewProject() {
  const navigate = useNavigate()

  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')
  const [fields, setFields] = useState<FieldDraft[]>([])
  const [error, setError] = useState('')
  const [submitting, setSubmitting] = useState(false)

  const updateField = (i: number, patch: Partial<FieldDraft>) =>
    setFields((prev) => prev.map((f, idx) => (idx === i ? { ...f, ...patch } : f)))

  const addField = () =>
    setFields((prev) => [...prev, { label: '', field_type: 'text', options: '' }])

  const removeField = (i: number) =>
    setFields((prev) => prev.filter((_, idx) => idx !== i))

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')
    setSubmitting(true)

    try {
      const token = localStorage.getItem('token')
      const headers = {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`,
      }

      const projectRes = await fetch('/api/projects', {
        method: 'POST',
        headers,
        body: JSON.stringify({ title, description }),
      })
      if (!projectRes.ok) {
        const body = await projectRes.json().catch(() => ({}))
        setError(body.error ?? 'Failed to create project')
        return
      }
      const project = await projectRes.json()

      for (const field of fields) {
        const fieldRes = await fetch(`/api/projects/${project.id}/fields`, {
          method: 'POST',
          headers,
          body: JSON.stringify({
            label: field.label,
            field_type: field.field_type,
            options: field.field_type === 'dropdown' ? field.options : undefined,
          }),
        })
        if (!fieldRes.ok) {
          const body = await fieldRes.json().catch(() => ({}))
          setError(body.error ?? 'Failed to create field')
          return
        }
      }

      navigate('/projects')
    } catch {
      setError('Network error — is the server running?')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <>
    <Header />
    <div className="auth-page">
      <div className="auth-card">
        <h1>New Project</h1>

        <form onSubmit={handleSubmit}>
          <div className="form-field">
            <label htmlFor="title">Title</label>
            <input
              id="title"
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Project title"
              required
            />
          </div>

          <div className="form-field">
            <label htmlFor="description">Description</label>
            <textarea
              id="description"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="What is this project about?"
              rows={4}
            />
          </div>

          <div>
            <h2>Observation Fields</h2>
            <button type="button" className="outline-button" onClick={addField}>+ Add Field</button>

            {fields.map((field, i) => (
              <div key={i} className="field-row">
                <div className="form-field">
                  <label htmlFor={`field-label-${i}`}>Label</label>
                  <input
                    id={`field-label-${i}`}
                    type="text"
                    value={field.label}
                    onChange={(e) => updateField(i, { label: e.target.value })}
                    placeholder="e.g. Bird color"
                    required
                  />
                </div>

                <div className="form-field">
                  <label htmlFor={`field-type-${i}`}>Type</label>
                  <select
                    id={`field-type-${i}`}
                    value={field.field_type}
                    onChange={(e) => updateField(i, { field_type: e.target.value as FieldType })}
                  >
                    {FIELD_TYPES.map((t) => (
                      <option key={t} value={t}>{t}</option>
                    ))}
                  </select>
                </div>

                {field.field_type === 'dropdown' && (
                  <div className="form-field">
                    <label htmlFor={`field-options-${i}`}>Options</label>
                    <input
                      id={`field-options-${i}`}
                      type="text"
                      value={field.options}
                      onChange={(e) => updateField(i, { options: e.target.value })}
                      placeholder="comma,separated,values"
                      required
                    />
                  </div>
                )}

                <button type="button" className="outline-button" onClick={() => removeField(i)}>Remove</button>
              </div>
            ))}
          </div>

          {error && <p className="auth-error" role="alert">{error}</p>}

          <button type="submit" className="auth-button" disabled={submitting}>
            Create Project
          </button>
        </form>

        <p className="auth-switch">
          <Link to="/projects">Back to projects</Link>
        </p>
      </div>
    </div>
    </>
  )
}

export default NewProject
