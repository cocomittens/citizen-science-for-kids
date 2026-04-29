import { BrowserRouter, Routes, Route } from 'react-router-dom'
import LandingPage from './scenes/LandingPage'
import Auth from './scenes/Auth'
import Projects from './scenes/Projects'

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/auth" element={<Auth />} />
        <Route path="/projects" element={<Projects />} />
      </Routes>
    </BrowserRouter>
  )
}

export default App
