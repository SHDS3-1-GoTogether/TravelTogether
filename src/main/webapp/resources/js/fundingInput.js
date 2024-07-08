
$(function() {

//보여줄 Option 페이지 선택

    const inputArr = ["input1", "input2", "input3", "input4", "input5"];

    for(var i = 1; i < 5; i++) {
    	$("#" + inputArr[i]).hide();
    }
    //$("#input1").hide();
 	//$("#input5").show();

	
	function showInputOption(inputOption) {
	    inputArr.forEach((option, index) => {
	    	if(option==inputOption)
	    		$("#" + option).show();
	    	else
	    		$("#" + option).hide();
	    });
	}

	    
//DB에 넣을 data
    const fund = {
		title : "",
		funding_content : "",
		create_date : "",
		area : "",
		start_date : "",
		end_date : "",
		deadline : "",
		price : "",
		departure : "",
		traffic : "",
		accommodation : "",
		people_num : "",
    }
 	    var accPicArr = "";
	    var trafficPicArr = "";   
	    var mainPicArr = "";
	    var extraPicArr = [];
	    
	    let themeSelection = [];
    	let themeTitle = [];
    	

		function f_inputKeypress(){
			var replaceNum = $(this).val($(this).val().replace(/[^0-9]/gi, ""));
			var currentObj = $(this).attr("id");
			var currentNum = $(this).val();			
			
			if(currentObj == "people_num") {
				if(currentNum < 2 || currentNum > 50) {
					$("#people_num_info").attr("style", "color:red");
					$(this).val(currentNum.slice(0,-1));
					$(this).focus();
				} else {
					$("#people_num_info").attr("style", "color:#4E548E");
				}
			} else if(currentObj == "price") {
				if(currentNum < 1 || currentNum > 10000000){
					$("#price_info").attr("style", "color:red");
					$(this).val(currentNum.slice(0,-1));
					$(this).focus();
				} else {
					$("#price_info").attr("style", "color:#4E548E");
				}
			}
		}
    	
    	$("input[type='number']").on("input", f_inputKeypress);
    	
    	

    
//fundingOption 1 페이지 js 
	    let currentMonth = new Date().getMonth()+1;
	    let currentYear = new Date().getFullYear();
	    
	    let startDate = null;
	    let endDate = null;
	    
    function renderCalendar(month, year, calendarId) {
        const $calendar = $('#' + calendarId);
        $calendar.empty();
        
        const $monthTitle = $('#' + calendarId + "-month");
        $monthTitle.empty();
        const $monthElement = $("<div>").addClass('month').text(month + "월");
        $monthTitle.append($monthElement);
        
        const $yearTitle = $('#yearWrapper');
        $yearTitle.empty();
        const $yearElement = $("<div>").addClass('year').text(year + '년');
        $yearTitle.append($yearElement);

        const firstDay = new Date(year, month - 1).getDay();
        const daysInMonth = new Date(year, month, 0).getDate();
        const daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

        daysOfWeek.forEach(day => {
            const $dayElement = $("<div>").addClass('daysOfWeek').text(day);
            $calendar.append($dayElement);
        });

        let date = 1;
        for (let i = 0; i < 6; i++) {
            for (let j = 0; j < 7; j++) {
                const $cell = $("<div>").addClass('day');
                if (i === 0 && j < firstDay) {
                    $cell.addClass('empty');
                } else if (date > daysInMonth) {
                    break;
                } else if(
                	(
                	(year == new Date().getFullYear())
                	 && 
                	 (month == (new Date().getMonth()+1 ))
                	 ) 
                		|| (
                	(year == (new Date().getFullYear())) 
                	 && 
                	(month == (new Date().getMonth()+2))
                	 && 
                	(date < new Date().getDate()) )
                		|| (
                	(year == (new Date().getFullYear()+1)) 
                	 && 
                	(month == (new Date().getMonth()+2))
                	 && 
                	(date > (new Date().getDate())) )
                	) {

                    $cell.text(date);
                    $cell.data('date', `${year}-${month}-${date}`);
                	$cell.addClass('empty');
                	
                	date++;
                } else {
                    $cell.text(date);
                    $cell.data('date', `${year}-${month}-${date}`);
                    $cell.on('click', dateClickHandler);
                    date++;
                }
                $calendar.append($cell);
            }
        }
    }

    function dateClickHandler(event) {
        const selectedDate = new Date($(event.target).data('date'));
        if (startDate && endDate) {
            clearSelection();
        }
        if (!startDate || (startDate && selectedDate < startDate)) {
            endDate = startDate;
            startDate = selectedDate;
            $(event.target).addClass('selected');
        } else if (!endDate || (endDate && selectedDate > endDate)) {
            endDate = selectedDate;
            $(event.target).addClass('selected');
        }
        if (startDate && endDate) {
            highlightDates();
        }
    }

    function highlightDates() {
        $('.day').each(function() {
            const cellDate = new Date($(this).data('date'));
            if (cellDate >= startDate && cellDate <= endDate) {
                $(this).addClass('range');
            }
        });
    }

    function clearSelection() {
        $('.day').removeClass('selected range');
        startDate = null;
        endDate = null;
    }

    function renderCalendars() {
        if (currentMonth == 0) {
            renderCalendar(12, currentYear-1, 'calendar1');
        } else {
            renderCalendar(currentMonth, currentYear, 'calendar1');
        }
        renderCalendar(currentMonth + 1, currentYear, 'calendar2');
    }

    $('#prev-button').on('click', function() {
        currentMonth -= 1;
        if ((currentMonth < (new Date().getMonth() + 1)) && (currentYear == new Date().getFullYear())) {
    	    alert("이전 달로 이동할 수 없습니다.");
        	currentMonth += 1;
	    } else {
	        if (currentMonth < 0) {
	            currentMonth += 12;
	            currentYear--;
        	}
        	renderCalendars();
	    }

    });

    $('#next-button').on('click', function() {
        currentMonth += 1;
        if((currentYear == (new Date().getFullYear()+1)) && (currentMonth == new Date().getMonth() +2)) {
        	alert("다음 달로 이동할 수 없습니다.");
        	currentMonth -= 1;
        } else {
	        if (currentMonth > 11) {
	            currentMonth -= 12;
	            currentYear++;
	        }
	        renderCalendars();        
        }

    });
    

    renderCalendars();
    
	 $('#submit1').on('click', function() {
		fund.area = $('#area').val();
		fund.people_num = $('#people_num').val();
		
		if(startDate == "" || startDate == null || fund.area == "" || fund.people_num =="") {
			alert("전부 입력해주세요");
		} else {
			fund.start_date = startDate;
			if(endDate == null || endDate =="")
				fund.end_date = startDate;
			else
				fund.end_date = endDate;
			showInputOption("input2");
	
			startDateFormat = startDate.getFullYear() +"-" + (startDate.getMonth()+1) + "-" + startDate.getDate();
			endDateFormat = fund.end_date.getFullYear() +"-" + (fund.end_date.getMonth()+1) + "-" + fund.end_date.getDate();
			fund.start_date = startDateFormat;
			fund.end_date = endDateFormat;
			$(".option-li-wrapper li:nth-child(1)").append("<div>"+ startDateFormat + "-" + endDateFormat +"</div>"); 
			$(".option-li-wrapper li:nth-child(2)").append("<div>"+ fund.area +"</div>"); 
			$(".option-li-wrapper li:nth-child(3)").append("<div>"+ fund.people_num +"명</div>"); 		
		}

	});
    

//fundingOption 2 페이지 js 
	
	$("#accommodation_pic").on("change", function(event){
	 	const accFile = event.target.files;
			
		$("#accImgArea").children().remove();
		accPicArr = null;
	 	if($(this).val() != "" )  {
	 		var image = new Image();
	 		var ImageTempUrl = window.URL.createObjectURL(accFile[0]);
	 		image.src = ImageTempUrl;
	 		image.style = "width:200px; height:200px; border-radius: 20px; box-shadow: 4px 4px 4px #4E548E; margin-bottom: 10px;";
	 		$("#accImgArea").append(image);
	 		accPicArr = document.getElementById('accommodation_pic').files[0];
	 	}
	 });
	 	
	$("#traffic_pic").on("change", function(event){
	 	const accFile = event.target.files;
	 	$("#trafficImgArea").children().remove();
	 	trafficPicArr = null;
	 	if($(this).val() != "" ) {
	 		var image = new Image();
	 		var ImageTempUrl = window.URL.createObjectURL(accFile[0]);
	 		image.src = ImageTempUrl;
	 		image.style = "width:200px; height:200px; border-radius: 20px; box-shadow: 4px 4px 4px #4E548E;margin-bottom: 10px;";
	 		$("#trafficImgArea").append(image);
	 		trafficPicArr = document.getElementById('traffic_pic').files[0];
	 	}
	 });
	 
	 $("#accommodation_pic").on('click', function() {
		accPicArr = "";
	 });
	 $("#traffic_pic").on('click', function() {
		trafficPicArr = "";
	 });
	 	

	
  
	
//fundingOption 3 페이지 js 

    let monthIndex = new Date().getMonth();
    let yearIndex = new Date().getFullYear();
    let selectedDate = null;

	
    function buildCalendar(month, year, containerId) {
        const $calendarContainer = $('#' + containerId);
        $calendarContainer.empty();
        
        const $monthContainer = $('#month-display');
        $monthContainer.empty();
        const $monthElement = $("<div>").addClass('month-title').text((month + 1) + "월");
        $monthContainer.append($monthElement);
        
        const $yearContainer = $('#year-display');
        $yearContainer.empty();
        const $yearElement = $("<div>").addClass('year-title').text(year + '년');
        $yearContainer.append($yearElement);

        const firstDayIndex = new Date(year, month, 1).getDay();
        const totalDaysInMonth = new Date(year, month + 1, 0).getDate();
        const weekDays = ['일', '월', '화', '수', '목', '금', '토'];

        weekDays.forEach(day => {
            const $dayElement = $("<div>").addClass('grid-cell-week').text(day);
            $calendarContainer.append($dayElement);
        });

        let dateNumber = 1;
        for (let i = 0; i < 6; i++) {
            for (let j = 0; j < 7; j++) {
                const $cell = $("<div>").addClass('grid-cell');
                if (i === 0 && j < firstDayIndex) {
                    $cell.addClass('empty-cell');
                } else if (dateNumber > totalDaysInMonth) {
                    break;
                } else if(
                	(((month+1) == startDate.getMonth()) && (dateNumber > startDate.getDate())) 
                	||
                	(((month+1) == (new Date().getMonth()+1)) && (dateNumber < new Date().getDate()))
                	) { 
                    $cell.text(dateNumber);
                    $cell.data('date', `${year}-${month + 1}-${dateNumber}`);
                    $cell.addClass('empty-cell');
                    dateNumber++;
                    
                } else {
                    $cell.text(dateNumber);
                    $cell.data('date', `${year}-${month + 1}-${dateNumber}`);
                    $cell.on('click', onDateClick);
                    dateNumber++;
                }
                $calendarContainer.append($cell);
            }
        }
    }

    function onDateClick(event) {
        if (selectedDate) {
            clearDateSelection();
        }
        selectedDate = $(event.target).data('date');
        $(event.target).addClass('selected-date');
    }

    function clearDateSelection() {
        $('.grid-cell').removeClass('selected-date');
        selectedDate = null;
    }

    function collectSelectedThemes() {
        themeSelection = [];
        themeTitle = [];
        $('input[name="theme"]:checked').each(function() {
        	let themeStr = $(this).val().split("/");        	
            themeSelection.push(themeStr[0]);
            themeTitle.push(themeStr[1]);
        });
    }

    function updateCalendar() {
        buildCalendar(monthIndex, yearIndex, 'calendar');
    }

    $('#prev-btn').on('click', function() {
        monthIndex -= 1;
        if( (yearIndex == new Date().getFullYear()) && (monthIndex < new Date().getMonth())) {
        	monthIndex += 1;
        	alert("이전 달로 이동할 수 없습니다.");
        } else {
	        if (monthIndex < 0) {
	            monthIndex += 12;
	            yearIndex--;
	        }
	        updateCalendar();        
        }

    });

    $('#next-btn').on('click', function() {
        monthIndex += 1;
        if(monthIndex > startDate.getMonth()-1) {
        	monthIndex -= 1;
        	alert("다음 달로 이동할 수 없습니다.");
        } else {
	        if (monthIndex > 11) {
	            monthIndex -= 12;
	            yearIndex++;
	        }
	        updateCalendar();        
        }

    });
    
      $('#submit2').on('click', function() {
    
    	if($("#accommodationCheck").is(":checked") && (($('#accommodation').val()=="") || (accPicArr == "") || (accPicArr == null))) {
    		alert("숙소와 예약내역사진을 입력하거나 숙소 예약 체크를 해제해주세요.");
    	} else if(($("#trafficCheck").is(":checked")) && (($('#traffic').val()=="") || ($('#departure').val()=="") || (trafficPicArr == "") || (trafficPicArr == null)) ) {
    		alert("교통수단, 출발지를 입력하거나 교통 예약 체크를 해제해주세요.");
    	} else {
    		if($("#accommodationCheck").is(":checked"))
    			fund.accommodation = $('#accommodation').val();
    		else
    			fund.accommodation = "";
    		if($("#trafficCheck").is(":checked")) {
				fund.traffic = $('#traffic').val();
				fund.departure = $('#departure').val();
			}
			else {
				fund.traffic = "";
				fund.departure = "";
			}
			
	
			showInputOption("input3");
			
			if(fund.accommodation != "") {
				$(".option-li-wrapper li:nth-child(4)").append("<div>"+ fund.accommodation +"</div>"); 
			} else {
				$(".option-li-wrapper li:nth-child(4)").append("<div>미정</div>"); 
				accPicArr = null;
			}
			if(fund.traffic != "") {
				$(".option-li-wrapper li:nth-child(5)").append("<div>"+ fund.traffic +", " + fund.departure + "에서 출발" +"</div>"); 
		 	} else {
				$(".option-li-wrapper li:nth-child(5)").append("<div>미정</div>"); 
				trafficPicArr = null;
		 	}
	
	    }
	    updateCalendar();
	});
    

    $('#submit3').on('click', function() {
        collectSelectedThemes();
        const price = $('#price').val();
     	
     	
     	if(selectedDate == "" || selectedDate == null) {
     		alert("펀딩 마감일을 입력해주세요.")
     	}  else if(price == "") {
     		alert("예산을 입력해주세요.")
     	} else {
	    	fund.deadline = selectedDate;
	    	fund.price = price;
	    	let themeStr = "";
	    	
	    	for(var i = 0; i < themeTitle.length; i++) {
	    		themeStr += " #" + themeTitle[i];
	    	}
	    	var price2 = fund.price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	    	$(".option-li-wrapper li:nth-child(6)").append("<div>"+ price2 + "원</div>"); 
	    	$(".option-li-wrapper li:nth-child(7)").append("<div>"+ themeStr +"</div>"); 
			$(".option-li-wrapper li:nth-child(8)").append("<div>"+ fund.deadline +"</div>"); 		
	    	
	    	showInputOption("input4");
    	}
    });


//fundingOption 4  페이지 js 
    $('#submit4').on('click', function() {

    	fund.title = $("#title").val();
    	var editor = CKEDITOR.instances['content'];
    	var content = editor.getData();
		console.log(content);
		fund.funding_content = content;
		if(fund.title == "") {
			alert("제목을 입력해주세요.");
		} else if(fund.funding_content == "") {
			alert("내용을 입력해주세요.");
		} else {
    		showInputOption("input5");
		}
    });
    
//fundingOption 5 페이지 js
$('#submit5').on('click', function() {
		if(mainPicArr == null || mainPicArr == "") {
			alert("메인 사진을 첨부헤주세요.");
		} else { 
		var value = $("input[name=extra_pics]");
		for(var i = 0; i < value.length; i++) {
			if(value[i].files[0] != null) {
				extraPicArr.push(value[i].files[0]);
			}
		}	
		
		var formData = new FormData();
		formData.append("fund", JSON.stringify(fund));
		formData.append("accPicArr", accPicArr);
		formData.append("trafficPicArr", trafficPicArr);
		formData.append("mainPicArr", mainPicArr);
		formData.append("theme", themeSelection);
		
		for(var i = 0; i < extraPicArr.length; i++) {
			formData.append("extraPicArr", extraPicArr[i]);
		}
          for (var pair of formData.entries()) {
                console.log(pair[0]+ ', ' + pair[1]); 
            }
		$.ajax({
			url: "../funding/fundingInput.do",
			enctype: 'multipart/form-data',
			type: "post",
			data: formData,
			contentType: false,
			processData:false,
			success:function(data) {
				if(data=="1") {
				swal(
					'펀딩 성공',
					'펀딩 제출에 성공했습니다. 관리자의 컨펌을 기다려주세요.',
					'success'
				).then(function() {
					location.href="fundingList.do";
				});
				} else {
				swal(
					'펀딩 실패',
					'펀딩 제출에 실패했습니다. 소중한 시간을 내어 다시 등록 부탁드립니다.',
					'error'
				)
				}
			}
		});
	}
	});
	
	$(document).on("change", "input[name=main_pic]", function() {
	 const mainPic = event.target.files;
	 
	 mainPicArr = null;
	 if(mainPic[0] != null ) {
	 	var image = $("#mainImageWrapper").children();
	 	var ImageTempUrl = window.URL.createObjectURL(mainPic[0]);
		image.removeAttr("class");
		image.removeAttr("src");
		image.attr("class", "selected-image");
		image.attr("src", ImageTempUrl);
	 	mainPicArr = $("input[name=main_pic]")[0].files[0];
	 }
	 
	 $("#main-image").on('click', function() {
	 	mainPicArr = null;
	 });
 });

	
});

	
function accommodCheck() {
	if($("#accommodationCheck").is(":checked")) {
		$("#accommodation").removeAttr("disabled");
		$("#acc-upload").on("click", function() {
			$("#accommodation_pic").click();
		});
	} else {
		$("#accommodation").attr("disabled", true);
		$("#acc-upload").off("click")
		$("#accImgArea").children().remove();
		$("#accommodation_pic").val("");	
	}
}
	
function trafficCheck() {
	if($("#trafficCheck").is(":checked")) {
		$("#traffic").removeAttr("disabled");
		$("#departure").removeAttr("disabled");
		$("#traffic-upload").on("click", function() {
			$("#traffic_pic").click();
		});
	} else {
		$("#traffic").attr("disabled", true);
		$("#departure").attr("disabled", true);
		$("#traffic-upload").off("click");
		$("#trafficImgArea").children().remove();
		$("#traffic_pic").val("");
	}
}

//FundingOption5 

let detailImageCount = 1;
let currentIndex = 0;


 function mainImageOnClick() {
 	$("#main-image").click();
 	
	var image =$("#mainImage");
	image.removeAttr("class");
	image.removeAttr("src");
	image.attr("class", "default-image");
	image.attr("src", "../resources/images/add_img.png");
 }


function detailImageOnClick(index) {
	$(`#detailImage${index}`).click();
	
		
	var image =$(`#detailImage${index}Preview`).children();
	image.removeAttr("class");
	image.removeAttr("src");
	image.attr("class", "default-image");
	image.attr("src", "../resources/images/add_img.png");
	
}
	
$(document).on("change", "input[name=extra_pics]", function() {
	const extraPic = event.target.files;
	var prefixId = $(this).attr('id');	
	
	if(extraPic[0] != null) {
		
		var image =$(`#${prefixId}Preview`).children();
		var ImageTempUrl = window.URL.createObjectURL(extraPic[0]);
		image.removeAttr("class");
		image.removeAttr("src");
		image.attr("class", "selected-image");
		image.attr("src", ImageTempUrl);
	}
});
	


 

function addDetailImage() {
    const container = document.getElementById('detailImageContainer');
    const newDiv = document.createElement('div');
    newDiv.classList.add('detail-image');
    
    newDiv.innerHTML = `
        <input type="file"  id="detailImage${detailImageCount}" name="extra_pics" accept="image/*" style="display:none" >
        <div id="detailImage${detailImageCount}Preview" class="image-preview" onclick="detailImageOnClick(${detailImageCount})">
            <img class="default-image" src="../resources/images/add_img.png" alt="Upload Icon"">
        </div>
        <button type="button" class="remove-icon" onclick="removeDetailImage(${detailImageCount})">X</button>
    `;
    container.appendChild(newDiv);
    detailImageCount++;
    updateSlider();
}

function removeDetailImage(index) {
    const imageDiv = document.getElementById(`detailImage${index}`).parentNode;
    imageDiv.parentNode.removeChild(imageDiv);
    updateSlider();
}

function updateSlider() {
    const container = document.getElementById('detailImageContainer');
    const detailImages = container.querySelectorAll('.detail-image');
    const containerWidth = document.querySelector('.image-slider').offsetWidth;
    const totalWidth = detailImages.length * (detailImages[0].offsetWidth + 10); // including margin-right
    container.style.width = `${totalWidth}px`;
    slideToIndex(currentIndex);
}

function slideLeft() {
    if (currentIndex > 0) {
        currentIndex--;
        slideToIndex(currentIndex);
    }
}

function slideRight() {
    const container = document.getElementById('detailImageContainer');
    const detailImages = container.querySelectorAll('.detail-image');
    if (currentIndex < detailImages.length - 1) {
        currentIndex++;
        slideToIndex(currentIndex);
    }
}

function slideToIndex(index) {
    const container = document.getElementById('detailImageContainer');
    const detailImages = container.querySelectorAll('.detail-image');
    const itemWidth = detailImages[0].offsetWidth + 10; // including margin-right
    const translateX = -index * itemWidth;
    container.style.transform = `translateX(${translateX}px)`;
}

document.addEventListener("DOMContentLoaded", updateSlider);



