document.addEventListener('DOMContentLoaded', function() {
    const gridWrap = document.querySelector(".grid-wrap");
    const navButton = document.getElementById("nav-mobile-button");
    navButton.addEventListener('click',function(){
        event.preventDefault();
        gridWrap.classList.toggle('menu-open');
        navButton.classList.toggle('fa-solid fa-bars')
    })
})