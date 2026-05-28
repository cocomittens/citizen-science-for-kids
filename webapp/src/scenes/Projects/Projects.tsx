import { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import Header from '../../components/Header'
import type { Project } from '../../types/types'
import { apiUrl } from '../../api'
import './Projects.css'

function Projects() {
  const navigate = useNavigate()
  const [projects, setProjects] = useState<Project[]>([])
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const load = async () => {
      try {
        const token = localStorage.getItem('token')
        const res = await fetch(apiUrl('/api/projects'), {
          headers: { Authorization: `Bearer ${token}` },
        })
        if (!res.ok) {
          const body = await res.json().catch(() => ({}))
          setError(body.error ?? 'Failed to load projects')
          return
        }
        setProjects(await res.json())
      } catch {
        setError('Network error — is the server running?')
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [])

  return (
    <>
    <Header />
    <div className="projects-page">
      <header>
        <div>
          <h1>My projects</h1>
          <p>{projects.length} projects</p>
        </div>
        <Link to="/projects/new" className="new-project-button">
          <span aria-hidden="true">+</span>
          New Project
        </Link>
      </header>

      {error && <p className="auth-error" role="alert">{error}</p>}
      {loading ? (
        <p>Loading…</p>
      ) : (
        <ul>
          {projects.map((project) => (
            <li key={project.id}>
              <div>
                <h2>{project.title}</h2>
                <p>{project.description}</p>
              </div>
              <div className="project-meta">
                <span>Code</span>
                <span>{project.class_code}</span>
              </div>
              <button type="button" onClick={() => navigate(`/projects/${project.id}/results`)}>
                View Results
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
    </>
  )
}

export default Projects
