<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--サイトのサイズ自動調整-->
<meta name="viewport"
	content="width=device-width,height=device-height,initial-scale=1.0">
<title>ToppingList</title>
<!-- .cssの呼び出し -->
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/popup.css">
<link rel="stylesheet" href="css/Topping/toppinglist.css">
<!-- ファビコン非表示 -->
<link rel="icon" href="data:," />
</head>
<body>
	<main>
		<div class="btn-row">
			<!--ホームボタン-->
			<form action="Home">
				<input type="image"
					src="<%=request.getContextPath()%>/image/homeButton.png"
					alt="ホームボタン" class="homebutton">
			</form>
			<!-- 新規作成ボタン -->
			<form action="ToppingCreateForm" method="post">
				<input type="hidden" name="form" value="ToppingCreate">
				<button type="submit" class="btn-create">新規作成</button>
			</form>
		</div>
		<div class="topping-box">
			<c:forEach var="topping" items="${toppingInfo}">
				<div class="topping-row">
					<div class="topping-name"><c:out value="${topping.name}" /></div>
					<div class="topping-price"><c:out value="${topping.price}" />円</div>

					<!-- 編集ボタンで商品新規作成・編集画面へ遷移する -->
					<form action="ToppingEditForm" method="post">
						<input type="hidden" name="form" value="ToppingEdit"> <input
							type="hidden" name="topping_id" value="${topping.id}"> <input
							type="hidden" name="topping_name" value="<c:out value='${topping.name}' />">
						<input type="hidden" name="topping_price" value="<c:out value='${topping.price}' />">
						<button class="btn-edit" type="submit">編集</button>
					</form>

					<!-- 表示フラグが1のとき：非表示にするボタン -->
					<button type="button"
						class="btn-toggle ${topping.visible_flag == 1 ? 'btn-hide' : 'btn-display'}"
						id="toggle-btn-${topping.id}"
						data-id="${topping.id}"
						data-visible-flag="${topping.visible_flag}"
						data-name="<c:out value='${topping.name}'/>"
						onclick="handleToppingToggle(this)">${topping.visible_flag == 1 ? '非表示にする' : '表示にする'}</button>
				</div>
			</c:forEach>
		</div>

	</main>
	<!--ポップアップの背景-->
	<div class="popup-overlay" id="popup-overlay"></div>
	<!--ポップアップの内容-->
	<div class="popup-content" id="popup-content">
		<p id="popup-product-name" class="text-bold"></p>
		<p id="popup-message"></p>
		<p>よろしいですか？</p>
		<!-- 商品の表示変更 -->
		<form action="ToppingList" method="post">
			<input type="hidden" name="topping_id" id="popup-topping-id">
			<input type="hidden" name="topping_visible_flag"
				id="popup-topping-visible-flag">
			<button type="submit" class="popup-proceed" id="confirm-button"
				data-action="" data-target-topping-id="">は い</button>
		</form>

		<button class="popup-close" id="close-popup">いいえ</button>
	</div>
	</main>
	<!-- .jsの呼び出し -->
	<script src="JavaScript/Popup.js"></script>
	<script src="JavaScript/setTabContent.js"></script>
</body>
</html>