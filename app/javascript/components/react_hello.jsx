import React from 'react';
import {createRoot} from 'react-dom/client'

const Hello = props => (
  <div>こんにちは {props.name} さん！! jsxでも大丈夫ですよ!!これでどうかな！</div>
)

Hello.defaultProps = {
  name: '名無し'
}

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('app');
  createRoot(container).render(<Hello name='SawaD' />);
})