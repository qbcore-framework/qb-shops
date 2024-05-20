local Translations = {
    info = {
        open_shop = '[E] Loja',
        deliver_e = '~g~E~w~ - Entregar Produtos',
        deliver = 'Entregar Produtos',
    },
    error = {
        missing_license = 'Licença %s ausente para certos produtos',
        no_deposit = '$%{value} Depósito necessário',
        cancelled = 'Cancelado',
        vehicle_not_correct = 'Este não é um veículo comercial!',
        no_driver = 'Você deve ser o condutor para fazer isso...',
        no_work_done = 'Você ainda não fez nada...',
        backdoors_not_open = 'As portas traseiras do veículo não estão abertas',
        get_out_vehicle = 'Você deve sair do veículo para executar esta ação',
        too_far_from_trunk = 'Você deve pegar as caixas do porta-malas do seu veículo',
        too_far_from_delivery = 'Você deve estar mais perto do ponto de entrega'
    },
    success = {
        dealer_verify = 'O concessionário verifica sua licença',
        paid_with_cash = '$%{value} Depósito pago em espécie',
        paid_with_bank = '$%{value} Depósito pago via banco',
        refund_to_cash = '$%{value} Depósito pago em espécie',
        you_earned = 'Você ganhou $%{value}',
        payslip_time = 'Você visitou todas as lojas... É hora de seu holerite!',
    },
    mission = {
        store_reached = 'Loja alcançada, pegue um cofre com [E] e entregue ao marcador',
        take_box = 'Pegue um cofre de produtos',
        deliver_box = 'Entregue um cofre de produtos',
        another_box = 'Pegue outro cofre de produtos',
        goto_next_point = 'Você entregou todos os produtos, vá para o próximo ponto',
        return_to_station = 'Você entregou todos os produtos, retorne à estação',
        job_completed = 'Você completou sua rota'
    },
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
