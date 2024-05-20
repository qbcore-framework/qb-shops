local Translations = {
    info = {
        open_shop = '[E] Tienda',
        deliver_e = '~g~E~w~ - Entregar Productos',
        deliver = 'Entregar Productos',
    },
    error = {
        missing_license = 'Falta una licencia %s para ciertos productos',
        no_deposit = '$%{value} Se requiere depósito',
        cancelled = 'Cancelado',
        vehicle_not_correct = 'Este no es un vehículo comercial!',
        no_driver = 'Debes ser el conductor para hacer esto...',
        no_work_done = 'Aún no has hecho ningún trabajo...',
        backdoors_not_open = 'Las puertas traseras del vehículo no están abiertas',
        get_out_vehicle = 'Necesitas salir del vehículo para realizar esta acción',
        too_far_from_trunk = 'Necesitas recoger las cajas del maletero de tu vehículo',
        too_far_from_delivery = 'Necesitas estar más cerca del punto de entrega'
    },
    success = {
        dealer_verify = 'El distribuidor verifica tu licencia',
        paid_with_cash = '$%{value} Depósito pagado con efectivo',
        paid_with_bank = '$%{value} Depósito pagado desde el banco',
        refund_to_cash = '$%{value} Depósito pagado con efectivo',
        you_earned = 'Has ganado $%{value}',
        payslip_time = 'Has visitado todas las tiendas... ¡Tiempo para tu recibo de pago!',
    },
    mission = {
        store_reached = 'Tienda alcanzada, toma una caja en el maletero con [E] y entrega al marcador',
        take_box = 'Toma una caja de productos',
        deliver_box = 'Entrega caja de productos',
        another_box = 'Toma otra caja de productos',
        goto_next_point = 'Has entregado todos los productos, al próximo punto',
        return_to_station = 'Has entregado todos los productos, regresa a la estación',
        job_completed = 'Has completado tu ruta'
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
