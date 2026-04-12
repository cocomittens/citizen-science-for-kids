import { useState } from 'react'
import { useSearchParams, Link } from 'react-router-dom'
import './Auth.css'

function Auth() {
  const [searchParams] = useSearchParams()
  const isSignUp = searchParams.get('mode') === 'signup'

  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [name, setName] = useState('')

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // TODO: make login actually work
  }

  return (
    <div className="auth-page">
      <div className="auth-card">
        <h1>{isSignUp ? 'Create Account' : 'Sign In'}</h1>

        <form onSubmit={handleSubmit}>
          {isSignUp && (
            <div className="form-field">
              <label htmlFor="name">Name</label>
              <input
                id="name"
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="Your name"
                required
              />
            </div>
          )}

          <div className="form-field">
            <label htmlFor="email">Email</label>
            <input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="you@example.com"
              required
            />
          </div>

          <div className="form-field">
            <label htmlFor="password">Password</label>
            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="••••••••"
              required
            />
          </div>

          <button type="submit" className="auth-button">
            {isSignUp ? 'Sign Up' : 'Sign In'}
          </button>
        </form>

        <p className="auth-switch">
          {isSignUp ? (
            <>
              Already have an account? <Link to="/auth?mode=signin">Sign In</Link>
            </>
          ) : (
            <>
              Don't have an account? <Link to="/auth?mode=signup">Sign Up</Link>
            </>
          )}
        </p>
      </div>
    </div>
  )
}

export default Auth
