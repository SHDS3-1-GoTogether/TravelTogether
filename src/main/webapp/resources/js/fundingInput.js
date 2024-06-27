
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
    
//fundingOption 1 페이지 js 
	    let currentMonth = new Date().getMonth();
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
            const $dayElement = $("<div>").addClass('day').text(day);
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
        if (currentMonth < 0) {
            currentMonth += 12;
            currentYear--;
        }
        renderCalendars();
    });

    $('#next-button').on('click', function() {
        currentMonth += 1;
        if (currentMonth > 11) {
            currentMonth -= 12;
            currentYear++;
        }
        renderCalendars();
    });
    

    renderCalendars();
    
	 $('#submit1').on('click', function() {
		fund.area = $('#area').val();
		fund.people_num = $('#people_num').val();
		
		if(startDate == "" || fund.area == "" || fund.people_num =="") {
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
	 		console.log(ImageTempUrl)
	 		$("#trafficImgArea").append(image);
	 		trafficPicArr = document.getElementById('traffic_pic').files[0];
	 	}
	 });
	 	

	
    $('#submit2').on('click', function() {
		fund.accommodation = $('#accommodation').val();
		fund.traffic = $('#traffic').val();
		fund.departure = $('#departure').val();
		

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
            const $dayElement = $("<div>").addClass('grid-cell').text(day);
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
        if (monthIndex < 0) {
            monthIndex += 12;
            yearIndex--;
        }
        updateCalendar();
    });

    $('#next-btn').on('click', function() {
        monthIndex += 1;
        if (monthIndex > 11) {
            monthIndex -= 12;
            yearIndex++;
        }
        updateCalendar();
    });

    $('#submit3').on('click', function() {
        collectSelectedThemes();
        const price = $('#price').val();
    	fund.deadline = selectedDate;
    	fund.price = price;
    	let themeStr = "";
    	
    	for(var i = 0; i < themeTitle.length; i++) {
    		themeStr += " #" + themeTitle[i];
    	}
    	
    	
    	$(".option-li-wrapper li:nth-child(6)").append("<div>"+ fund.price +"</div>"); 
    	$(".option-li-wrapper li:nth-child(7)").append("<div>"+ themeStr +"</div>"); 
		$(".option-li-wrapper li:nth-child(8)").append("<div>"+ fund.deadline +"</div>"); 		
    	
    	showInputOption("input4");
    });

    updateCalendar();

//fundingOption 4  페이지 js 
    $('#submit4').on('click', function() {

    	fund.title = $("#title").val();
    	fund.funding_content = $("#content").val();

    	
    	showInputOption("input5");
    });

//fundingOption 5 페이지 js 
	function addImg() {
		$("#extraImg").append("<div class='extraImg'><input type='file' accept='image/*' name='extra_pics'><span onclick='removeImg(this)'>x</span></div>");
	}
	function removeImg(id) {
		$(id).parent().remove();
	}
	
	$(document).on("change", "input[name=extra_pics]", function() {
		const extraPic = event.target.files;
		
        let nextElement = $(this).next();
        if (nextElement.is('img')) {
            nextElement.remove();
        }		
		
		if($(this).val() != "" ) {
		 	var image = new Image();
		 	var ImageTempUrl = window.URL.createObjectURL(extraPic[0]);
		 	image.src = ImageTempUrl;
		 	$(this).after(image);
		}
	});
	
	$("input[name=main_pic]").on("change", function(event){
		 const mainPic = event.target.files;
		 $("#mainImgArea").children().remove();
		 mainPicArr = null;
		 if($(this).val() != "" ) {
		 	var image = new Image();
		 	var ImageTempUrl = window.URL.createObjectURL(mainPic[0]);
		 	image.src = ImageTempUrl;
		 	$("#mainImgArea").append(image);
		 	mainPicArr = $("input[name=main_pic]")[0].files[0];
		 }
	 });
	
	$('#submit5').on('click', function() {
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
				console.log(data);
			}
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

