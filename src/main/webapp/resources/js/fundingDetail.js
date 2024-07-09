$(document).ready(function() {
	console.log(images.length);
	
	let indexNow = 0;
	let maxIndex = images.length - 1;
	
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
            
			let container = $(".slider__thumnail");
			var width = 0;

            //왼쪽 버튼 클릭
            Slider.PreviousBtn.addEventListener("click", function(){
                event.preventDefault();
                if(indexNow >= 0) {
                	indexNow--;
                	width += 100;
					const container = $(".slider__thumnail").children();
					container.attr("style",`transform:translateX(${width}px); transition: 1s ease;`);
            	}
            });

            //오른쪽 버튼 클릭
            Slider.NextBtn.addEventListener("click", function(){
                event.preventDefault();
				if(indexNow < (images.length + 1 - maxIndex)) {
					indexNow++;
					width -= 100;
					const container = $(".slider__thumnail").children();
					container.attr("style",`transform:translateX(${width}px); transition: 1s ease;`);
				}
            });
        }
        ImageSlider(document.querySelector(".slider__wrap"),images);
	
});

 