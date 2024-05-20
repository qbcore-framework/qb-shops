local Translations = {
    info = {
        open_shop = '[E] Magasin',
        deliver_e = '~g~E~w~ - Livrer des produits',
        deliver = 'Livrer des produits',
    },
    error = {
        missing_license = 'Licence %s manquante pour certains produits',
        no_deposit = '$%{value} Dépôt requis',
        cancelled = 'Annulé',
        vehicle_not_correct = 'Ce nest pas un véhicule commercial!',
        no_driver = 'Vous devez être le conducteur pour faire cela...',
        no_work_done = "Vous n'avez encore rien fait...",
        backdoors_not_open = 'Les portes arrière du véhicule ne sont pas ouvertes',
        get_out_vehicle = 'Vous devez sortir du véhicule pour effectuer cette action',
        too_far_from_trunk = 'Vous devez prendre les boîtes dans le coffre de votre véhicule',
        too_far_from_delivery = 'Vous devez être plus près du point de livraison'
    },
    success = {
        dealer_verify = 'Le concessionnaire vérifie votre licence',
        paid_with_cash = '$%{value} Dépôt payé en espèces',
        paid_with_bank = '$%{value} Dépôt payé par banque',
        refund_to_cash = '$%{value} Dépôt payé en espèces',
        you_earned = 'Vous avez gagné $%{value}',
        payslip_time = 'Vous avez visité tous les magasins... Cest lheure de votre feuille de paie!',
    },
    mission = {
        store_reached = 'Magasin atteint, prenez un coffre avec [E] et livrez au marqueur',
        take_box = 'Prenez un coffre de produits',
        deliver_box = 'Livrez un coffre de produits',
        another_box = 'Prenez un autre coffre de produits',
        goto_next_point = 'Vous avez livré tous les produits, allez au prochain point',
        return_to_station = 'Vous avez livré tous les produits, retournez à la station',
        job_completed = 'Vous avez terminé votre tournée'
    },
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
