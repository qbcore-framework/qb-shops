local Translations = {
    info = {
        open_shop = '[E] Магазин',
        deliver_e = '~з~E~ъ~ - Достави Продукти',
        deliver = 'Достави Продукти',
    },
    error = {
        missing_license = 'Липсва лиценз за %s за определени продукти',
        no_deposit = '$%{value} Deposit Required',
        cancelled = 'Отменено',
        vehicle_not_correct = 'Това не е търговско превозно средство!',
        no_driver = 'Трябва да бъдете шофьорът, за да извършите това..',
        no_work_done = 'Вие все още не сте извършили никаква работа..',
        backdoors_not_open = 'Задните врати на превозното средство не са отворени',
        get_out_vehicle = 'Трябва да излезете от превозното средство, за да извършите това действие',
        too_far_from_trunk = 'Трябва да вземете кутиите от багажника на вашето превозно средство',
        too_far_from_delivery = 'Трябва да бъдете по-близо до точката за доставка'
    },
    success = {
        dealer_verify = 'Търговецът проверява вашия лиценз',
        paid_with_cash = '$%{value} Deposit Paid With Cash',
        paid_with_bank = '$%{value} Deposit Paid From Bank',
        refund_to_cash = '$%{value} Deposit Paid With Cash',
        you_earned = 'Вие спечелихте $%{value}',
        payslip_time = 'Вие посетихте всички магазини .. Време за вашата заплата!',
    },
    mission = {
        store_reached = 'Магазинът е достигнат, вземете кутия в багажника с [E] и доставете до маркера',
        take_box = 'Вземете кутия с продукти',
        deliver_box = 'Доставете кутия с продукти',
        another_box = 'Вземете още една кутия с продукти',
        goto_next_point = 'Вие сте доставили всички продукти, към следващата точка',
        return_to_station = 'Вие сте доставили всички продукти, върнете се към станцията',
        job_completed = 'Вие сте завършили маршрута си'
    },
}

if GetConvar('qb_locale', 'en') == 'bg' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
