import React from 'react';
import {createRoot} from 'react-dom/client'

const Another = props => (
  <div>また会ったね {props.name} さん！!</div>
)

Another.defaultProps = {
  name: '名無し'
}

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('another-app');
  if (container) {
    createRoot(container).render(<Another name='SawaD' />);
  } else {
    console.log('another-app not found');
  }
})