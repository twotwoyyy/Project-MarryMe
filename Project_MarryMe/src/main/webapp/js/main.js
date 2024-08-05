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
    
    let target=$(this).attr('data-list');
    product_list.each(function(){
        if($(this).hasClass(target)){
            product_list.removeClass('active');
            $(this).addClass('active');
        }
    })
})

/* --------------- list ----------------- */
let list_tab=$('#list .cate_list > li'),
    brand_list=$('#list .brand_list');
$('#list .cate_list > li').click(function(){
    $(this).siblings('li').removeClass('active');
    $(this).addClass('active');

    let target=$(this).attr('data-list');
    brand_list.each(function(){
        if($(this).hasClass(target)){
            brand_list.removeClass('active');
            $(this).addClass('active');
        }
    })
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
/* --------------- AOS ----------------- */
AOS.init();

/* --------------- DATEPICKER ----------------- */
let date_input=$("#detail #calendar");
date_input.datepicker();
date_input.focus(); 
$("#ui-datepicker-div td .ui-state-default").click(function(){
    date_input.css("visibility","visible");
});