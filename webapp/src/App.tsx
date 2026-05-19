import { BrowserRouter, Routes, Route } from 'react-router-dom'
import LandingPage from './scenes/LandingPage'
import Auth from './scenes/Auth'
import Projects from './scenes/Projects'
import NewProject from './scenes/NewProject'

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/auth" element={<Auth />} />
        <Route path="/projects" element={<Projects />} />
        <Route path="/projects/new" element={<NewProject />} />
      </Routes>
    </BrowserRouter>
  )
}

export default App
