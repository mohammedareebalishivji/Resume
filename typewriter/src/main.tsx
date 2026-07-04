import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import Typewriter from './Typewriter'

const root = document.getElementById('typewriter-root')
if (root) {
  createRoot(root).render(
    <StrictMode>
      <Typewriter />
    </StrictMode>,
  )
}
