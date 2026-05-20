import { useNavigate } from 'react-router-dom'
import './Header.css'

function Header() {
  const navigate = useNavigate()

  const logout = () => {
    localStorage.removeItem('token')
    navigate('/auth?mode=signin')
  }

  return (
    <div className="app-header">
      <button type="button" className="outline-button" onClick={logout}>
        Logout
      </button>
    </div>
  )
}

export default Header
