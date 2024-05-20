local Translations = {
    info = {
        open_shop = '[E] متجر',
        deliver_e = '~ج~ه~و~ - تسليم المنتجات',
        deliver = 'تسليم المنتجات',
    },
    error = {
        missing_license = 'مفقود رخصة %s لمنتجات معينة',
        no_deposit = 'مطلوب_Deposit $%{value}',
        cancelled = 'ملغي',
        vehicle_not_correct = 'هذه ليست مركبة تجارية!',
        no_driver = 'يجب أن تكون السائق لتقوم بهذا...',
        no_work_done = 'لم تقم بأي عمل بعد..',
        backdoors_not_open = 'باب الخلفية للمركبة غير مفتوح',
        get_out_vehicle = 'تحتاج إلى الخروج من المركبة لتنفيذ هذا الإجراء',
        too_far_from_trunk = 'تحتاج إلى استلام الصناديق من الخلفية للمركبة',
        too_far_from_delivery = 'تحتاج إلى أن تكون أقرب إلى نقطة التسليم'
    },
    success = {
        dealer_verify = 'يُتحقّق التاجر من رخصتك',
        paid_with_cash = 'دفع_Deposit $%{value} نقداً',
        paid_with_bank = 'دفع_Deposit $%{value} من البنك',
        refund_to_cash = 'دفع_Deposit $%{value} نقداً',
        you_earned = 'كسبت $%{value}',
        payslip_time = 'لقد زرت جميع المتاجر .. حان الوقت لبayar slip!',
    },
    mission = {
        store_reached = 'وصلت إلى المتجر، احصل على صندوق في الخلفية مع [E] وتسليمه إلى العلامة',
        take_box = 'خذ صندوقاً من المنتجات',
        deliver_box = 'تسليم صندوق من المنتجات',
        another_box = 'خذ صندوقاً آخر من المنتجات',
        goto_next_point = 'لقد سلمت جميع المنتجات، الى النقطة التالية',
        return_to_station = 'لقد سلمت جميع المنتجات، عود إلى المحطة',
        job_completed = 'لقد أكملت مسارك'
    },
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
