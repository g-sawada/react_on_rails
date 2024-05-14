import React from 'react';
import { createRoot } from 'react-dom/client'
import { StyledEngineProvider } from '@mui/material/styles';
import BottomDrawer from './bottom_drawer';

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('app');
  if (container) {
    createRoot(container).render(<Hello name='SawaD' />);
  } else {
    console.log('app not found');
  }
})

const Hello = props => (
  <>
    <div>こんにちは {props.name} さん！!</div>
    <div>今度こそ，このアプリはGitHub Actionsで自動デプロイされています！</div>
    <StyledEngineProvider injectFirst>
      <BottomDrawer />
    </StyledEngineProvider>
  </>
)

Hello.defaultProps = {
  name: '名無し'
}


