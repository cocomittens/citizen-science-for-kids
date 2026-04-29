import './Projects.css'

type Project = {
  id: string
  name: string
  description: string
  code: string
  students: number
}

const projects: Project[] = [
  {
    id: '1',
    name: 'Project 1',
    description: 'Description for project 1 goes here. Short explanation of what the project is.',
    code: 'ABCD-123',
    students: 12,
  },
  {
    id: '2',
    name: 'Project 2',
    description: 'Description for project 2 goes here. Short explanation of what the project is.',
    code: 'ABCD-123',
    students: 15,
  },
  {
    id: '3',
    name: 'Project 3',
    description: 'Description for project 3 goes here. Short explanation of what the project is.',
    code: 'ABCD-123',
    students: 11,
  },
  {
    id: '4',
    name: 'Project 4',
    description: 'Description for project 4 goes here. Short explanation of what the project is.',
    code: 'ABCD-123',
    students: 25,
  },
]

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
