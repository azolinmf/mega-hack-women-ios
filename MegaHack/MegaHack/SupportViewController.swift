//
//  SupportViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 05/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SupportViewController: UIViewController {

    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tableViewContainer: UIView!
    
    var sizes: [CGFloat] = []
    
    let tableView:UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topContainer.layer.cornerRadius = 50.0
        topContainer.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.2
        
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.minimumScaleFactor = 0.2
        
        setUpTableView()
    }

    func setUpTableView() {
        tableViewContainer.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: tableViewContainer.topAnchor, constant: 15).isActive = true
        tableView.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor, constant: 32).isActive = true
        tableView.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor, constant: -32).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableViewContainer.bottomAnchor, constant: -5).isActive = true
        
        tableView.register(TipCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    @IBAction func didPressBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let tips = [
        Tip(title: "Como comprovar despesas?", descriptionText: "\tUm dos questionamentos entre quem paga e quem recebe pensão alimentícia é o modo como o dinheiro gasto. Uma alternativa para deixar tudo bem definido é a prestação de contas dos gastos com o dinheiro recebido, prevista em uma lei ainda pouco conhecida.\n\tA Lei 13.058/2014, que atualizou o instituto da guarda compartilhada, introduzido no direito brasileiro em 2008, possibilita a quem paga pensão exigir comprovantes formais dos gastos com as necessidades desses dependentes, com base no §5º do artigo 1583 do Código Civil.\n\tAs ações de prestação de contas servem apenas para receber informações, não para rever os valores dos alimentos. O desencadeamento vai ser por meio de ações revisionais que vão buscar a redução do valor em caso de abuso na utilização desse dinheiro.\n\tNa dúvida, se a relação entre os pais não for amigável, é prudente guardar os recibos do maior número possível de notas de compras e serviços relativos à criança.\n\tDessa forma, com a funçao de exportar gastos, Ninho te oferece um arquivo em formato pdf com os gastos mensais com o dependente."),
        Tip(title: "Atrasos com o pagamento da Pensão Alimentícia", descriptionText: "Além de ações para estipular quanto deverá ser pago, há outra grande questão: o pagamento atrasa, como cobrar? A partir de quanto tempo é possível realizar a cobrança? Quais as consequências para o devedor? \n\tPara que ocorra o atraso, é necessário que essa pensão alimentícia primeiramente esteja estipulada formalmente. Isso pode ocorrer de duas formas: judicialmente (a mais comum), quando tratamos de direito de incapaz (menor de idade, pessoas interditadas, dentre outras) e extrajudicialmente (quando estipulado em acordo para maior de idade que ainda necessita para os estudos ou alimentos para ex-cônjuge). Os famosos acordos 'de boca' não são considerados para cobrança de ação de alimentos. Portanto, **sempre formalize a pensão alimentícia!**\n\tCaso o pagamento esteja estipulado para uma data específica do mês, a pensão já poderá ser cobrada no dia seguinte ao combinado se o devedor não pagar. No entanto, por bom senso, recomenda-se que espere 30 dias para acionar o devedor judicialmente.\n\tA cobrança ocorrerá na Justiça. Existem, no entanto, dois caminhos para se tomar:\n\t**PRISÃO CIVIL:** É a mais famosa. Ela é considerada uma medida drástica, que força o devedor a pagar logo a dívida. No entanto, ela só pode abranger **os últimos 3 meses em atraso, não mais do que isso**. Depois que o devedor é citado (toma conhecimento formal que está sendo cobrado), tem 3 dias para pagar a dívida, comprovar que já pagou ou justificar o porquê ficou sem pagar. Se nesse prazo não fazer nada, poderá ser **preso em regime fechado e ainda ter seu nome negativado no SPC**.\n\t**PENHORA DOS BENS (EXPROPRIAÇÃO):** Quem cobra pensão muitas vezes não quer ver o devedor preso. Ainda, este modelo aceita mais de 3 meses de cobrança, diferente da prisão civil.\n\tSe o devedor ainda sim não pagar, poderá ter sua conta bancária penhorada, transferindo de imediato o valor para a conta de quem recebe pensão.\n\tPelo rito da **prisão civil** é no máximo os **3 últimos meses em atraso**.\n\tJá no rito de penhora dos bens (expropriação), com o credor sendo **menor de idade**, é possível a cobrança de **todos os atrasados**, devidamente atualizados e corrigidos monetariamente. No entanto, se essa pessoa já é **maior de idade** é possível cobrar no **máximo os últimos 2 anos**!\n\tPortanto, fique atenta(o)!"),
        Tip(title: "Situações de violência doméstica", descriptionText: "É do interesse deste aplicativo atentar para qualquer tipo de violência dentro de casa, informando e resguardando os nossos usuários.\n\tAssim, são formas de violência domésticas:\n\t1. **Humilhar, xingar e diminuir a autoestima**\n\tCondutas como humilhação, desvalorização moral ou deboche público em relação a(o) parceira(o) constam como tipos de violência emocional.\n\t2. **Tirar a liberdade de crença**\n\tNenhuma pessoa pode restringir a ação, a decisão ou a crença de outra. Isso também é considerado como uma forma de violência psicológica.\n\t3. **Fazer com que a parceira(o) ache que está ficando louca(o)**\n\tHá inclusive um nome para isso: o *gaslighting*. Uma forma de abuso mental que consiste em distorcer os fatos e omitir situações para deixar a vítima em dúvida sobre a sua memória e sanidade.\n\t4. **Controlar e oprimir**\n\tAqui o que conta é o comportamento obsessivo de alguém sobre o outro, como querer controlar o que se faz, a forma como se veste, não deixando a(o) parceira(o) sair, isolar sua família e amigos ou procurar mensagens no celular ou e-mail. As condutas descritas podem caracterizar violência psicológica.\n\t5. **Expor a vida íntima**\n\tFalar sobre a vida do casal para outros é considerado uma forma de violência moral, como, por exemplo, vazar fotos íntimas nas redes sociais como forma de vingança.\n\t6. **Atirar objetos, sacudir e apertar os braços**\n\tNem toda violência física é o espancamento. São considerados também como abuso físico a tentativa de arremessar objetos com a intenção de machucar, sacudir e segurar com força.\n\t7. **Forçar atos sexuais desconfortáveis**\n\tNão é só forçar o sexo que consta como violência sexual. Obrigar a fazer atos sexuais que causam desconforto ou repulsa, como a realização de fetiches, também é violência.\n\t8. **Impedir a mulher de prevenir a gravidez ou obrigá-la a abortar**\n\tO ato de impedir uma mulher de usar métodos contraceptivos, como a pílula do dia seguinte ou o anticoncepcional, é considerado uma prática da violência sexual. Da mesma forma, obrigar uma mulher a abortar também é outra forma de abuso.\n\t9. **Controlar o dinheiro ou reter documentos**\n\tSe algum dos envolvidos no relacionamento tenta controlar, guardar ou tirar o dinheiro do outro contra a sua vontade, assim como reter documentos pessoais, isso é considerado uma forma de violência patrimonial.\n\t10. **Quebrar objetos pessoais**\n\tOutra forma de violência ao patrimônio é causar danos de propósito a objetos da pessoa, ou objetos que se goste.")
    ]
    
    var selectedIndex: IndexPath = IndexPath(row: -1, section: -1)
}

extension SupportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath {
            if sizes.count >= tips.count {
                return sizes[indexPath.row] + 100
            }
            return 200
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TipCell
        
        cell.tip = tips[indexPath.row]
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 8.0
        cell.backgroundColor = .clear
        
        cell.animate()
        
        sizes.append(cell.descriptionText.bounds.size.height)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [selectedIndex], with: .none)
        tableView.endUpdates()
    }
}


