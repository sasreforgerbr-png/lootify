const app = document.getElementById('app');
const gridRoot = document.getElementById('grid-root');
const titleEl = document.getElementById('title');
document.getElementById('btnClose').onclick = () => {
  fetch(`https://lootify/close`, { method: 'POST', body: '{}' }).catch(() => {});
  app.style.display = 'none';
};

// NUI Callbacks
window.addEventListener('message', (e) => {
  const msg = e.data;
  if (!msg || !msg.action) return;
  if (msg.action === 'open') {
    titleEl.textContent = (msg.config && msg.config.title) || 'Lootify';
    app.style.display = 'block';
    renderTemplate(msg.data && msg.data.grids || []);
  }
});

// Draws a grid of size w x h
function drawGrid(w, h) {
  const grid = document.createElement('div');
  grid.className = 'grid';
  grid.style.gridTemplateColumns = `repeat(${w}, 40px)`;
  grid.style.gridTemplateRows = `repeat(${h}, 40px)`;
  for (let r = 0; r < h; r++) {
    for (let c = 0; c < w; c++) {
      const cell = document.createElement('div');
      cell.className = 'cell';
      grid.appendChild(cell);
    }
  }
  return grid;
}

// Renders the nested template as in the example provided
function renderTemplate(template) {
  gridRoot.innerHTML = '';
  template.forEach((entry, idx) => {
    if (Array.isArray(entry)) {
      // a row with blocks
      const row = document.createElement('div');
      row.className = 'row';
      entry.forEach(block => {
        const div = document.createElement('div');
        div.className = 'block';
        div.appendChild(drawGrid(block.w, block.h));
        row.appendChild(div);
      });
      gridRoot.appendChild(row);
    } else if (typeof entry === 'object' && entry.w && entry.h) {
      gridRoot.appendChild(drawGrid(entry.w, entry.h));
    }
  });
}

// NUI <-> Lua
window.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') {
    document.getElementById('btnClose').click();
  }
});

// Expose save (example)
function save() {
  fetch(`https://lootify/save`, { method: 'POST', body: JSON.stringify({}) }).catch(() => {});
}
