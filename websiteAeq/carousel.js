const carousel = document.querySelector(".carousel-wrap");
const arrows = document.querySelectorAll(".content-wrap i");
const firstCardWidth = carousel.querySelector(".carousel-card").offsetWidth ;
const carouselChildren  = [...carousel.children]

let isDragging = false,startX, startScrollLeft;


function goRight(car,cardWidth){
    const resetScrollDistance = car.scrollWidth - car.clientWidth+120;
    console.log(car.scrollLeft + cardWidth, resetScrollDistance)
    if(car.scrollLeft+cardWidth >resetScrollDistance){
            car.scrollTo({
                left:0,
                behavior: 'smooth',
            });
        }else{
            car.scrollBy({
                left: cardWidth,
                behavior:'smooth',
            })
        } 
    }


    function goLeft(car,cardWidth){
    const resetScrollDistance = car.scrollWidth - car.clientWidth+120;
        if(car.scrollLeft-cardWidth < 0){
                car.scrollTo({
                    left:resetScrollDistance,
                    behavior: 'smooth',
                });
        }else{
            car.scrollBy({
                left: -cardWidth,
                behavior:'smooth',
            })
        }             
    }      

arrows.forEach(btn =>{
    btn.addEventListener("click", () =>{
        if (btn.id == "right-button"){
            goRight(carousel,firstCardWidth);
        }
        else{
            goLeft(carousel,firstCardWidth);
        }
    })
})

const dragStart = (e) =>{
    isDragging = true;
    carousel.classList.add("dragging")
    startX = e.pageX;
    startScrollLeft = carousel.scrollLeft
}

const dragging = (e) => {
    if(!isDragging) return;
    carousel.scrollLeft = startScrollLeft -  (e.pageX - startX);
}

dragStop = () =>{
    isDragging = false;
    carousel.classList.remove("dragging")
}

const interval = 5000;
const Speccarousel = document.querySelectorAll(".spec-carousel-wrap");

function autoScroll(){
    for(let i = 0;i<Speccarousel.length;++i){
        goRight(Speccarousel[i],firstCardWidth);
    }
}

let scroll_Interval = setInterval(autoScroll,interval);


carousel.addEventListener("mousedown",dragStart);
carousel.addEventListener("mousemove",dragging);
document.addEventListener("mouseup",dragStop)