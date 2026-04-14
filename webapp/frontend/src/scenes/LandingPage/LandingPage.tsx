import { Link } from 'react-router-dom'
import './LandingPage.css'

function LandingPage() {
  return (
    <div className="landing-page">
      <h1 className="landing-title">Citizen Science App for Kids</h1>
      <p className="landing-tagline">Create and manage citizen science projects for your classroom</p>
      <div className="landing-actions">
        <Link to="/auth?mode=signin" className="landing-button">Sign In</Link>
        <Link to="/auth?mode=signup" className="landing-button landing-button--outline">Sign Up</Link>
      </div>
    </div>
  )
}

export default LandingPage
