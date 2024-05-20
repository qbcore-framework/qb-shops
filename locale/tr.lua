local Translations = {
    info = {
        open_shop = '[E] Mağaza',
        deliver_e = '~g~E~w~ - Ürünleri Teslim Et',
        deliver = 'Ürünleri Teslim Et',
    },
    error = {
        missing_license = 'Belirli ürünler için %s lisansı eksik',
        no_deposit = '$%{value} Depozito Gerekli',
        cancelled = 'İptal Edildi',
        vehicle_not_correct = 'Bu ticari bir araç değil!',
        no_driver = 'Bunu yapmak için sürücü olmalısınız..',
        no_work_done = 'Henüz herhangi bir iş yapmadınız..',
        backdoors_not_open = 'Aracın arka kapıları açık değil',
        get_out_vehicle = 'Bu işlemi gerçekleştirmek için araçtan inmelisiniz',
        too_far_from_trunk = 'Kutu almak için aracınızın bagajına gitmelisiniz',
        too_far_from_delivery = 'Teslimat noktasına daha yakın olmalısınız'
    },
    success = {
        dealer_verify = 'Satıcı lisansınızı doğruluyor',
        paid_with_cash = '$%{value} Depozito Nakit Olarak Ödendi',
        paid_with_bank = '$%{value} Depozito Bankadan Ödendi',
        refund_to_cash = '$%{value} Depozito Nakit Olarak Geri Ödendi',
        you_earned = '$%{value} Kazandınız',
        payslip_time = 'Tüm Mağazalara Gittiniz .. Maaş Zamanı!',
    },
    mission = {
        store_reached = 'Mağazaya ulaştınız, bagajdan bir kutu alın [E] ve işarete teslim edin',
        take_box = 'Bir Kutu Ürün Alın',
        deliver_box = 'Bir Kutu Ürün Teslim Edin',
        another_box = 'Başka Bir Kutu Ürün Alın',
        goto_next_point = 'Tüm ürünleri teslim ettiniz, sonraki noktaya gidin',
        return_to_station = 'Tüm ürünleri teslim ettiniz, istasyona dönün',
        job_completed = 'Rotanızı Tamamladınız'
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
