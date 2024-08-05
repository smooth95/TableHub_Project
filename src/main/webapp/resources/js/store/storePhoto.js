function openModal(src) {
  document.getElementById('myModal').style.display = 'flex';
  document.getElementById('modalImg').src = src;
}

function closeModal() {
  document.getElementById('myModal').style.display = 'none';
}

// 클릭 시 모달 닫기
window.onclick = function(event) {
  if (event.target == document.getElementById('myModal')) {
    closeModal();
  }
}