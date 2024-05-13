import React from 'react';
import {createRoot} from 'react-dom/client'

const Hello = props => (
  <div>こんにちは {props.name} さん！!</div>
)

Hello.defaultProps = {
  name: '名無し'
}

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('app');
  if (container) {
    createRoot(container).render(<Hello name='SawaD' />);
  } else {
    console.log('app not found');
  }
})