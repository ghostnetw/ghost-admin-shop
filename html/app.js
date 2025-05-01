let categories = [];
let selected = null;

window.addEventListener('message', function(event) {
    if (event.data.action === 'openShop') {
        categories = event.data.categories;
        renderCategories();
        document.getElementById('cash-amount').innerText = `$${event.data.cash.toLocaleString()}`;
        document.body.style.display = 'block';
    }
    if (event.data.action === 'closeShop') {
        document.body.style.display = 'none';
    }
    if (event.data.action === 'feedback') {
        showFeedback(event.data.message, event.data.success);
    }
});

document.body.style.display = 'none';

function renderCategories() {
    const grid = document.getElementById('categories-grid');
    grid.innerHTML = '';
    categories.forEach(cat => {
        const card = document.createElement('div');
        card.className = 'category-card';
        card.innerHTML = `
            <div class="category-header ${cat.color}">
                <span class="category-icon">${cat.icon}</span>
                ${cat.name}
            </div>
            <ul class="item-list">
                ${cat.items.map(item => `
                    <li onclick="selectItem('${cat.name}','${item.name}','${item.id}',${item.price}, this)">
                        <span>${item.name}</span>
                        <span class="item-price">$${item.price}</span>
                    </li>
                `).join('')}
            </ul>
        `;
        grid.appendChild(card);
    });
}

window.selectItem = function(category, name, id, price, el) {
    document.querySelectorAll('.item-list li').forEach(li => li.classList.remove('selected'));
    el.classList.add('selected');
    selected = { category, name, id, price };
    document.getElementById('selected-item').innerText = `Selected Item: ${name}`;
};

document.getElementById('purchase-btn').onclick = function() {
    if (!selected) {
        alert('Select an item first!');
        return;
    }
    const qty = parseInt(document.getElementById('quantity').value) || 1;
    const method = document.getElementById('payment-method').value;
    fetch(`https://${GetParentResourceName()}/buyItem`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            category: selected.category,
            name: selected.name,
            id: selected.id,
            price: selected.price,
            amount: qty,
            method: method
        })
    });
};

function showFeedback(msg, success) {
    const fb = document.getElementById('selected-item');
    fb.innerText = msg;
    if (success) {
        selected = null;
        document.querySelectorAll('.item-list li').forEach(li => li.classList.remove('selected'));
    }
}

document.getElementById('close-btn').onclick = function() {
    fetch(`https://${GetParentResourceName()}/closeShop`, { method: 'POST' });
}; 