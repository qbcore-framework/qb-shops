local Translations = {
    info = {
        open_shop = '[E] მაღაზია',
        deliver_e = '~g~E~w~ - პროდუქტის მიწოდება',
        deliver = 'პროდუქტის მიწოდება',
    },
    error = {
        missing_license = 'გაქვთ %s ლიცენზია გარკვეული პროდუქტებისთვის',
        no_deposit = '$%{value} დეპოზიტი აუცილებელია',
        cancelled = 'გაუქმებულია',
        vehicle_not_correct = 'ეს არ არის კომერციული მანქანა!',
        no_driver = 'თქვენ უნდა იყოთ მძღოლი ამის გასაკეთებლად..',
        no_work_done = 'ჯერ არ გაგიკეთებიათ მუშაობა..',
        backdoors_not_open = 'მანქანის უკანა კარი არ არის გახსნილი',
        get_out_vehicle = 'თქვენ უნდა გამოხვიდეთ მანქანიდან ამ ქმედების შესასრულებლად',
        too_far_from_trunk = 'თქვენ უნდა აიღოთ ყუთები მანქანის საბარგულიდან',
        too_far_from_delivery = 'თქვენ უნდა იყოთ უფრო ახლოს მიწოდების წერტილთან'
    },
    success = {
        dealer_verify = 'დილერი ამოწმებს თქვენს ლიცენზიას',
        paid_with_cash = '$%{value} დეპოზიტი გადახდილი ნაღდი ფულით',
        paid_with_bank = '$%{value} დეპოზიტი გადახდილი ბანკიდან',
        refund_to_cash = '$%{value} დეპოზიტი დაბრუნებულია ნაღდი ფულით',
        you_earned = 'თქვენ გამოიმუშავეთ $%{value}',
        payslip_time = 'თქვენ ეწვიეთ ყველა მაღაზიას .. დროა მიიღოთ თქვენი ანაზღაურება!',
    },
    mission = {
        store_reached = 'მაღაზია მიღწეულია, აიღეთ ყუთი საბარგულიდან [E] და მიიტანეთ მარკერთან',
        take_box = 'აიღეთ პროდუქტის ყუთი',
        deliver_box = 'მოიტანეთ პროდუქტის ყუთი',
        another_box = 'მიიტანეთ კიდევ ერთი პროდუქტის ყუთი',
        goto_next_point = 'თქვენ მიიტანეთ ყველა პროდუქტი, გადადით შემდეგ წერტილზე',
        return_to_station = 'თქვენ მიიტანეთ ყველა პროდუქტი, დაბრუნდით სადგურზე',
        job_completed = 'თქვენ დაასრულეთ თქვენი მარშრუტი'
    },
}

if GetConvar('qb_locale', 'en') == 'ge' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
