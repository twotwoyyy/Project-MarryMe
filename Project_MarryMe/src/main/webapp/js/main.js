if($('#main').length > 0){
	/* --------------- BANNER ----------------- */
	$('.banner_slide').slick({
	    autoplay:true,
	    autoplaySpeed:5500,
	    dots:false,
	    arrows:false,
	    pauseOnHover:false,
	    pauseOnFocus:false,
	    fade:true,
	    speed:1000,
	    cssEase:'linear'
	});
	
	/* --------------- HALL ----------------- */
	$('.hall_slide').slick({
	    slidesToShow: 4,
	    slidesToScroll: 1,
	    autoplay:true,
	    autoplaySpeed:2000,
	    dots:false,
	    arrows:false,
	    pauseOnFocus:false,
	});
	
	/* --------------- STUDIO ----------------- */
	$('.studio_slide').slick({
	    slidesToShow: 3,
	    slidesToScroll: 1,
	    autoplay:true,
	    autoplaySpeed:2000,
	    dots:false,
	    arrows:false,
	    pauseOnFocus:false,
	});
	
	/* --------------- GOODS ----------------- */
	let goods_tab=$('#goods .goods_tab li'),
	    product_list=$('#goods .product_list');
	goods_tab.click(function(){
	    $(this).siblings('li').removeClass('active');
	    $(this).addClass('active');
	})
}

/* --------------- JOIN -----------------*/
if($('#join').length > 0){
    let join_date=$('#join input#wedding_date');
    join_date.datepicker({
        minDate: 0,
        dateFormat:'yy-mm-dd',
    });
    $('input.idCheck').click(function(){
		$('#idcheck_box').addClass('active');
		$('body').addClass('active');
	})
	
}
if($('#idcheck_box').length>0){
	$('#idcheck_box button.close').click(function(){
		$('#idcheck_box').removeClass('active');
		$('body').removeClass('active');
	})	
}

/* --------------- LOGIN -----------------*/
if($('#login').length > 0){
	let login_input=$('#login form .login_box input');
	login_input.change(function(){
		if($(this).val()!==""){
			$(this).siblings('label').addClass('active');
		}else{
			$(this).siblings('label').removeClass('active');
		}
	})
}

/* --------------- LOGIN -----------------*/
if($('#member_find').length > 0){
	let find_tab=$('#member_find .tab > li');
	find_tab.click(function(){
		let target=$(this).attr('data-tab');
		$(this).siblings('li').removeClass('active');
		$(this).addClass('active');
		$('.find_box').removeClass('active');
		$('#'+target).addClass('active');
	})
	
	let find_acco=$('.find_box .acco > p');
	find_acco.click(function(){
		if($(this).parents('.acco').hasClass('active')){
			$(this).parents('.acco').removeClass('active');
		}else{
			$('.acco').removeClass('active');
			$(this).parents().addClass('active');			
		}
	})
}
/* --------------- LIST ----------------- */
if($('#list').length > 0){
    let list_tab=$('#list .cate_list > li'),
        brand_list=$('#list .brand_list');
    list_tab.click(function(){
        $(this).siblings('li').removeClass('active');
        $(this).addClass('active');
    })
    $('#list .latest_slide').slick({
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay:true,
        autoplaySpeed:2000,
        dots:false,
        arrows:true,
        pauseOnFocus:false,
    });
    /* -------- AOS --------- */
    AOS.init();
}
/* --------------- DETAIL ----------------- */
if($('#detail').length > 0){
   /* ----- TAB SCROLL ----- */
	let tab_box=$('#detail .detail_tab'),
        tabOST=tab_box.offset().top;
    $(window).scroll(function(){
        let scrollAmt=$(window).scrollTop();
        if(scrollAmt > tabOST - 100){
            tab_box.css({position:'fixed'});
            tab_box.addClass('fixed');
        }else{
            tab_box.css({position:'static'})
            tab_box.removeClass('fixed');
        }
    })
    
    let detail_tab=$('#detail .detail_tab > li a'),
    	detail_content=$('#detail .bottom_content > div');
    detail_tab.click(function(e){
        e.preventDefault();
        $(this).addClass('active');
        $(this).parent().siblings('li').children('a').removeClass('active');
        let target_link = $(this).attr('href'),
        targetOST = $(target_link).offset().top;
        $('html, body').animate({scrollTop:targetOST-130,});
    });
    $(window).scroll(function(){
        let scrollAmt=$(window).scrollTop()
        detail_content.each(function(){
			let detail_con_top=$(this).offset().top,
				target='#'+$(this).attr("id");
	        if(scrollAmt > detail_con_top-150){
				detail_tab.each(function(i){
					if(target==detail_tab.eq(i).attr('href')){
						detail_tab.eq(i).addClass('active');
					}else{
						detail_tab.eq(i).removeClass('active');
					}
				})
	        }		
		})
    })
    
	if($('#detail #image .masonry_wrap').length>0){
    /* ------ MASONRY ------ */
   		let img_masonry=$('#detail #image .masonry_wrap');
    	img_masonry.imagesLoaded(function() {
		    img_masonry.masonry({
		        itemSelector: '.img_wrap',
		        columnWidth: '.img_wrap',
		        gutter: 10,
		        fitWidth: true,
		    });
    	})
    }

    /* ----- DATEPICKER ----- */
    let date_input=$("#detail #calendar");
    date_input.datepicker({
        minDate: 0,
        dateFormat:'yy-mm-dd',
        onSelect:function(date){
            date_click();
            $('.ui-datepicker .ui-datepicker-prev').add($('.ui-datepicker .ui-datepicker-next')).click(function(){
                date_click();
            })
            $('#detail .reservation .date_print').text(date);
        }
    });
    date_input.focus(); 
    function date_click(){
        $("#ui-datepicker-div td .ui-state-default").click(function(){
            date_input.css("visibility","visible");
            $("#ui-datepicker-div td .ui-state-default").removeClass('active');
            $(this).addClass('active');
            $('.reservation .time_btn').removeClass('active');
            $('.reservation .time_print').text("");
        });
    }
    date_click();
    let datepicker=$('#ui-datepicker-div');
    $('#detail .reserve_form .date').append(datepicker);

    /* ----- RESERVATION ----- */
    let reserve_box=$('#detail aside.reservation'),
        reserveOST=reserve_box.offset().top,
        detail_right=$('#detail .detail_wrap .right').width();
    $(window).scroll(function(){
        let scrollAmt=$(window).scrollTop();
        if(scrollAmt > reserveOST - 100){
            reserve_box.css({position:'sticky',
                width:detail_right+'px'
            })
            reserve_box.addClass('sticky');
        }else{
            reserve_box.css({position:'static',
                width:'auto'
            })
            reserve_box.removeClass('sticky');
        }
    })

    $('#detail .reservation .time_btn').click(function(e){
        e.preventDefault();
        $('#detail .reservation .time_btn').removeClass('active');
		if(!$(this).hasClass('impossible')){
	        $(this).addClass('active');
	        let target=$(this).text();
	        $('#detail .reservation .time_print').text(target);				
        }
    })


  
    /* ----- REVIEW / QNA INPUT----- */
    let insert_btn=$('#detail .board_top button');
    insert_btn.click(function(){
        $(this).parent().siblings('.detail_input').toggleClass('active');
        $(this).parent().siblings('.detail_input').children('textarea').val("");
        $(this).parent().siblings('.detail_input').find('.star').removeClass('active');
        $('#qna_pw').val("");
    })
}