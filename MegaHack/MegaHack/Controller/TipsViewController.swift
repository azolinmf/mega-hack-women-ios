//
//  TipsViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 05/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {

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

        initialUI()
        
        setUpTableView()
    }
    
    func initialUI() {
        topContainer.layer.cornerRadius = 50.0
        topContainer.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.2
        
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.minimumScaleFactor = 0.2
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
        Tip(title: "Como separar as tarefas?", descriptionText: "\tUma coisa importante a destacar e para se manter em mente é que não há realmente uma fórmula que sirva para todos. Aquilo que faz a família “Silva” feliz não é necessariamente o que contribui para a felicidade da família “Xavier”. Logo, o diálogo é sempre a primeira forma de negociação que indicamos.\n\tQuando ambos trabalham fora de casa é muito menos provável que as tarefas domésticas possam recair totalmente sobre um dos membros do casal do que quando um dos integrantes da família não trabalha ou trabalha em casa. Contudo, isso pode acontecer e em ambas as situações, é preciso que haja uma divisão harmoniosa para que ambos se sintam felizes. Essa divisão pode ser feita através de preferencias pessoais em relação à tarefa que cada um prefere realizar e esta é a nossa segunda dica.\n\tÉ bem difícil gostar de fazer tarefa doméstica por prazer, mas é fácil existir um determinado tipo de tarefa que nos incomode mais que outras. Procurar saber e dividir com inteligência os afazeres entre os membros utilizando a dica um é um grande trunfo na harmonia familiar.\n\tOutro problema é o fato de que colocamos muita expectativas sobre o trabalho do próximo. Esperar que o seu companheiro(a) faça as tarefas domésticas à sua maneira é injusto e desajustado. Deve-se sempre considerar que temos modos e visões diferentes sobre como cada tarefa doméstica deve ser realizada e sobre qual seria o resultado final apropriado. Ter atenção a expectativas não alcançáveis é a nossa terceira dica."),
        Tip(title: "Esgotamento mental e físico", descriptionText: "\tÉ importante levar em consideração como o esgotamento mental, também chamado de Síndrome de Burnout, e físico deteriora as relações interpessoais dentro de casa. Para todos que desejam uma coexistência pacífica e feliz, é necessário zelar pela saúde das pessoas ao nosso redor, tendo consciência que sobrecarregar um membro não é o melhor caminho.\n\tUm bom início de resolução é detectar o problema. Sendo assim, te damos algumas exemplos para te ajudar a notar sintomas de esgotamento em si mesmo ou no próximo:\n\tAlterações de humor:\n\tSeus sentimentos têm se tornado uma montanha-russa? Em certos momentos você está feliz, alegre, confiante, e em outros está triste e desanimado? Isso acontece pois os altos picos de estresse fazem com que ocorram essas oscilações de humor, que vão de um pólo a outro rapidamente.\n\tDificuldade de concentração:\n\tA dificuldade de concentração acaba se tornando rotineira na vida de quem tem Burnout, sendo um dos principais sintomas de esgotamento mental. Em muitos casos, também ocorre a perda de memória recente. Com tanto cansaço, o cérebro acaba não processando tantas informações com eficiência.\n\tIrritabilidade/agressividade:\n\tVocê tem ficado irritado ou agressivo com frequência? Quando a mente está sobrecarregada, acaba ficando mais difícil fazer o processamento desses sentimentos de maneira sensata. Eles simplesmente saem de maneira involuntária, e você passa a responder a todos os estímulos externos de maneira agressiva."),
        Tip(title: "Como evitar o esgotamento", descriptionText: "\tApós conhecer os indicativos de esgotamento físico e mental, é necessário aplicar novos hábitos saudáveis à rotina para combater — de maneira preventiva — essa condição. Dessa forma, te damos algumas dicas:\n\t1. Relaxamento/meditação:\n\tA meditação, assim como o relaxamento, pode trazer grandes melhorias para a saúde! Diversos estudos apontam que meditar reduz o estresse, melhora a concentração, o sono, e diminui a ansiedade. Comece aos poucos, com 15 a 20 minutos por dia, e você logo sentirá a diferença.\n\t2. Exercícios físicos\n\tA prática de exercícios físicos faz bem para todas as áreas da vida! Durante a execução dessas atividades, o cérebro libera um neuro-hormônio chamado endorfina, que regula a emoção e a percepção de dor e ajuda a produzir sensações de bem-estar e prazer.\n\t3. Atividades de lazer:\n\tSe envolver em algo que gostamos faz muito bem para nosso equilíbrio mental e corporal! Pode ser desde uma leitura de livro, tocar algum instrumento ou fazer um piquenique no parque. Por isso,faça algum hobbie para se acalmar, dedique um tempo somente para você fazer o que gosta.\n\t4. Procure ajuda:\n\tFaça uma reflexão sobre seu estilo de vida, procure ajuda de amigos, familiares e até mesmo profissional, para que você consiga lidar com essas questões e realize as mudanças necessárias para ter mais saúde e bem estar.")
    ]
    
    var selectedIndex: IndexPath = IndexPath(row: -1, section: -1)
}

struct Tip {
    var title: String
    var descriptionText: String
}

extension TipsViewController: UITableViewDelegate, UITableViewDataSource {
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

