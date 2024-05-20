local Translations = {
    info = {
        open_shop = '[E] Loja',
        deliver_e = '~g~E~w~ - Entregar Produtos',
        deliver = 'Entregar Produtos',
    },
    error = {
        missing_license = 'Falta uma licença %s para certos produtos',
        no_deposit = 'Depósito de $%{value} Requerido',
        cancelled = 'Cancelado',
        vehicle_not_correct = 'Este não é um veículo comercial!',
        no_driver = 'Você deve ser o motorista para fazer isso..',
        no_work_done = 'Você ainda não fez nenhum trabalho..',
        backdoors_not_open = 'As portas traseiras do veículo não estão abertas',
        get_out_vehicle = 'Você precisa sair do veículo para executar esta ação',
        too_far_from_trunk = 'Você precisa pegar as caixas do porta-malas do seu veículo',
        too_far_from_delivery = 'Você precisa estar mais perto do ponto de entrega'
    },
    success = {
        dealer_verify = 'O comerciante verifica sua licença',
        paid_with_cash = 'Depósito de $%{value} pago em dinheiro',
        paid_with_bank = 'Depósito de $%{value} pago pelo banco',
        refund_to_cash = 'Depósito de $%{value} devolvido em dinheiro',
        you_earned = 'Você ganhou $%{value}',
        payslip_time = 'Você visitou todas as lojas.. Hora do seu contracheque!',
    },
    mission = {
        store_reached = 'Loja alcançada, pegue uma caixa no porta-malas com [E] e entregue ao marcador',
        take_box = 'Pegue uma Caixa de Produtos',
        deliver_box = 'Entregue a Caixa de Produtos',
        another_box = 'Pegue outra Caixa de Produtos',
        goto_next_point = 'Você entregou todos os produtos, para o próximo ponto',
        return_to_station = 'Você entregou todos os produtos, retorne à estação',
        job_completed = 'Você completou sua rota'
    },
}

if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
