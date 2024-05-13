import React from 'react';
import {createRoot} from 'react-dom/client'

const Graph = () => (
  <div>グラフ!!</div>
)

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('graph-app');
  if (container) {
    createRoot(container).render(<Graph />);
  } else {
    console.log('graph-app not found');
  }
})