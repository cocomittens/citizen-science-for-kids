import { Link } from 'react-router-dom'
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
        <Link to="/projects/new" className="new-project-button">
          <span aria-hidden="true">+</span>
          New Project
        </Link>
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