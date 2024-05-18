import React from 'react'

const Alert = ({message, type="primary"}) => {
  return (
    <div className={`alert alert-${type}`} role="alert">
      {message}
    </div>
  )
}

export default Alert
