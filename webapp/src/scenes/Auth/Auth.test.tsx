import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { MemoryRouter } from 'react-router-dom'
import { describe, it, expect } from 'vitest'
import Auth from './Auth'

function renderAuth(initialRoute = '/auth?mode=signin') {
  return render(
    <MemoryRouter initialEntries={[initialRoute]}>
      <Auth />
    </MemoryRouter>
  )
}

describe('Auth - Sign In', () => {
  it('displays header text', () => {
    renderAuth()
    expect(screen.getByRole('heading', { name: 'Sign In' })).toBeInTheDocument()
  })

  it('displays email and password fields', () => {
    renderAuth()
    expect(screen.getByLabelText('Email')).toBeInTheDocument()
    expect(screen.getByLabelText('Password')).toBeInTheDocument()
  })

  it('does not display the name field', () => {
    renderAuth()
    expect(screen.queryByLabelText('Name')).not.toBeInTheDocument()
  })

  it('displays a submit button', () => {
    renderAuth()
    expect(screen.getByRole('button', { name: 'Sign In' })).toBeInTheDocument()
  })

  it('shows a link to switch to sign up', () => {
    renderAuth()
    const link = screen.getByRole('link', { name: 'Sign Up' })
    expect(link).toBeInTheDocument()
    expect(link).toHaveAttribute('href', '/auth?mode=signup')
  })

  it('updates email and password fields on input', async () => {
    const user = userEvent.setup()
    renderAuth()

    const emailInput = screen.getByLabelText('Email')
    const passwordInput = screen.getByLabelText('Password')

    await user.type(emailInput, 'test@example.com')
    await user.type(passwordInput, 'pass123')

    expect(emailInput).toHaveValue('test@example.com')
    expect(passwordInput).toHaveValue('pass123')
  })
})

describe('Auth - Sign Up', () => {
  it('displays header text', () => {
    renderAuth('/auth?mode=signup')
    expect(screen.getByRole('heading', { name: 'Create Account' })).toBeInTheDocument()
  })

  it('displays name, email, and password fields', () => {
    renderAuth('/auth?mode=signup')
    expect(screen.getByLabelText('Name')).toBeInTheDocument()
    expect(screen.getByLabelText('Email')).toBeInTheDocument()
    expect(screen.getByLabelText('Password')).toBeInTheDocument()
  })

  it('displays a submit button', () => {
    renderAuth('/auth?mode=signup')
    expect(screen.getByRole('button', { name: 'Sign Up' })).toBeInTheDocument()
  })

  it('shows a link to switch to sign in', () => {
    renderAuth('/auth?mode=signup')
    const link = screen.getByRole('link', { name: 'Sign In' })
    expect(link).toBeInTheDocument()
    expect(link).toHaveAttribute('href', '/auth?mode=signin')
  })

  it('updates the name field on input', async () => {
    const user = userEvent.setup()
    renderAuth('/auth?mode=signup')

    const nameInput = screen.getByLabelText('Name')
    await user.type(nameInput, 'Jane Doe')

    expect(nameInput).toHaveValue('Jane Doe')
  })
})
