import './Projects.css'
import { projects } from '../../mockData'

function Projects() {
  return (
    <div className="projects-page">
      <div className="projects-card">
        <header className="projects-header">
          <div className="projects-header-text">
            <h1 className="projects-title">My projects</h1>
            <p className="projects-count">{projects.length} projects</p>
          </div>
          <button type="button" className="projects-new-button">
            <span className="projects-new-icon" aria-hidden="true">+</span>
            New Project
          </button>
        </header>

        <ul className="projects-list">
          {projects.map((project) => (
            <li key={project.id} className="project-item">
              <div className="project-summary">
                <h2 className="project-name">{project.name}</h2>
                <p className="project-description">{project.description}</p>
              </div>
              <div className="project-meta">
                <span className="project-meta-label">Code</span>
                <span className="project-meta-value">{project.code}</span>
              </div>
              <div className="project-meta">
                <span className="project-meta-label">Students</span>
                <span className="project-meta-value">{project.students}</span>
              </div>
              <button type="button" className="project-view-button">
                View Results
              </button>
            </li>
          ))}
        </ul>
      </div>
    </div>
  )
}

export default Projects
