import { BrowserRouter, Routes, Route } from 'react-router-dom'
import LandingPage from './scenes/LandingPage'
import Auth from './scenes/Auth'

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/auth" element={<Auth />} />
      </Routes>
    </BrowserRouter>
  )
}

export default App
