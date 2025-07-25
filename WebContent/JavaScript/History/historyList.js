/**
 * 
 */
/*タブのカテゴリーに合った商品を表示する*/
document.addEventListener('DOMContentLoaded', () => {
	
	//全てのラジオボタンを取得
	const tabs = document.querySelectorAll('input[name="tab"]');
	
	//全ての注文一覧が入っている親要素を取得
	const orderBox = document.querySelector('.tab-contents');
	
	//サーバーから渡された以前選択されたカテゴリー名を取得
	const categoryFromServer = document.getElementById('initial-selected-category')?.value;
	
	//カテゴリー配列から該当するインデックスを取得(nullの場合「全て」をデフォルトにする)
	let selectedIndex = categoryList.indexOf(categoryFromServer || '全て');
	
	// 現在チェックされているラジオボタンのインデックスがあれば、そちらを優先する
	const selectedRadio = document.querySelector('input[name="tab"]:checked');
	if (selectedRadio) {
		selectedIndex = Array.from(tabs).indexOf(selectedRadio);
	}	
	
	// 選択中のカテゴリ名を取得
	const selectedCategory = categoryList[selectedIndex] || '全て';

	//全てのフォームの hidden input に現在のカテゴリを設定
	document.querySelectorAll('form').forEach(form => {
		const hidden = form.querySelector('.selected-category');
		if (hidden) hidden.value = selectedCategory;
	});

	//「戻す」ボタン押下時にも、現在のカテゴリをセット
	document.querySelectorAll('.order_return').forEach(button => {
		button.addEventListener('click', function () {
			let selectedIndex = Array.from(tabs).findIndex(tab => tab.checked);
			const category = categoryList[selectedIndex] || '全て';
			// 対象のフォームにカテゴリをセット
			const form = this.closest('form');
			const hidden = form.querySelector('.selected-category');
			if (hidden) hidden.value = category;
		});
	});

	//初期フィルター表示
	const orders = orderBox.querySelectorAll('.order_row');
	orders.forEach(order => {
		const orderCategory = order.getAttribute('data-table');
		order.classList.remove('hidden-row');
		order.style.display = (selectedCategory === '全て' || orderCategory === selectedCategory) ? '' : 'none';
	});

	//タブ変更時のフィルター表示
	tabs.forEach((tab, index) => {
		tab.addEventListener('change', () => {
			const selectedCategory = categoryList[index];
			orders.forEach(order => {
				const orderCategory = order.getAttribute('data-table');
				order.style.display = (selectedCategory === '全て' || orderCategory === selectedCategory) ? '': 'none';
			});

			//タブ変更時にも hidden を更新
			document.querySelectorAll('.selected-category').forEach(input => {
				input.value = selectedCategory;
			});
		});
	});
});
