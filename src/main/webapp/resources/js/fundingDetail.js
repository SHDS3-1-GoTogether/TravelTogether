$(document).ready(function() {
	console.log(images[0]);
	
	function ImageSlider (parent, images) {
            let currentIndex = 0;
            //선택자
            let Slider = {

                parent : parent,
                images : parent.querySelector(".slider__img"),
                thumnail : parent.querySelector(".slider__thumnail"),
                PreviousBtn : parent.querySelector(".slider__btn .previous"),
                NextBtn : parent.querySelector(".slider__btn .next")
            }

            //이미지를 화면에 출력
            Slider.images.innerHTML = images.map((image, index)=>{
                return `<img src="${image}" alt="이미지${index}" class="thumnail-images">`
            }).join("");

            //큰 활성화 시 효과
            let imageNode = Slider.images.querySelectorAll("img");
            imageNode[currentIndex].classList.add("active");
            
            //썸네일에 이미지 출력
            Slider.thumnail.innerHTML = Slider.images.innerHTML;

             //썸네일에 active 활성화
             let thumnailNode = Slider.thumnail.querySelectorAll("img");
             thumnailNode[currentIndex].classList.add("active");
    
            thumnailNode.forEach((el, i) => {
                el.addEventListener("click", function(){
	                event.preventDefault();
	                Slider.thumnail.querySelector("img.active").classList.remove("active");
	                el.classList.add("active");
	
	                imageNode[currentIndex].classList.remove("active");
	                currentIndex = i;
	                imageNode[currentIndex].classList.add("active")
                });
            });

            //왼쪽 버튼 클릭
            Slider.PreviousBtn.addEventListener("click", function(){
             	event.preventDefault();
               imageNode[currentIndex].classList.remove("active");
               currentIndex--;

               if(currentIndex < 0) currentIndex = images.length - 1;
               imageNode[currentIndex].classList.add("active");

                //활성화 되는 이미지와 같은 썸네일에 active 활성화
                Slider.thumnail.querySelector("img.active").classList.remove("active");
                thumnailNode[currentIndex].classList.add("active");

            });

            //오른쪽 버튼 클릭
            Slider.NextBtn.addEventListener("click", function(){
                event.preventDefault();
                imageNode[currentIndex].classList.remove("active");

                currentIndex = (currentIndex + 1) % images.length;
                imageNode[currentIndex].classList.add("active");

                //활성화 되는 이미지와 같은 썸네일에 active 활성화
                Slider.thumnail.querySelector("img.active").classList.remove("active");
                thumnailNode[currentIndex].classList.add("active");
            });
        }
        ImageSlider(document.querySelector(".slider__wrap"),images);
	
});

 