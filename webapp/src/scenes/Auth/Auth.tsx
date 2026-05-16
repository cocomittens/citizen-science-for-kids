import { useState } from 'react'
import { useSearchParams, useNavigate, Link } from 'react-router-dom'
import './Auth.css'

function Auth() {
  const [searchParams] = useSearchParams()
  const navigate = useNavigate()
  const isSignUp = searchParams.get('mode') === 'signup'

  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [name, setName] = useState('')
  const [error, setError] = useState('')
  const [submitting, setSubmitting] = useState(false)

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')
    setSubmitting(true)

    try {
      if (isSignUp) {
        const registerRes = await fetch('/api/auth/register', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ email, password }),
        })
        if (!registerRes.ok) {
          const body = await registerRes.json().catch(() => ({}))
          setError(body.error ?? 'Sign up failed')
          return
        }
      }

      const loginRes = await fetch('/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password }),
      })
      if (!loginRes.ok) {
        const body = await loginRes.json().catch(() => ({}))
        setError(body.error ?? 'Sign in failed')
        return
      }

      const { token } = await loginRes.json()
      localStorage.setItem('token', token)
      navigate('/projects')
    } catch {
      setError('Network error — is the server running?')
    } finally {
      setSubmitting(false)
    }
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

          {error && <p className="auth-error" role="alert">{error}</p>}

          <button type="submit" className="auth-button" disabled={submitting}>
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
