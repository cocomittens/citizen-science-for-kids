import './Projects.css'
import { projects } from '../../mockData'

function Projects() {
  return (
    <div className="projects-page">
      <header>
        <div>
          <h1>My projects</h1>
          <p>{projects.length} projects</p>
        </div>
        <button type="button">
          <span aria-hidden="true">+</span>
          New Project
        </button>
      </header>

      <ul>
        {projects.map((project) => (
          <li key={project.id}>
            <div>
              <h2>{project.name}</h2>
              <p>{project.description}</p>
            </div>
            <div className="project-meta">
              <span>Code</span>
              <span>{project.code}</span>
            </div>
            <div className="project-meta">
              <span>Students</span>
              <span>{project.students}</span>
            </div>
            <button type="button">View Results</button>
          </li>
        ))}
      </ul>
    </div>
  )
}

export default Projects