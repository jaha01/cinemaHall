//
//  HallView.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import UIKit

class HallView: UIView {
    
    // MARK: - Public Properties
    
    let hallMapView: UIView = { // Внутри будет схема зала
        let hallMapView = UIView()
        hallMapView.translatesAutoresizingMaskIntoConstraints = false
        return hallMapView
    }()
    
    // MARK: - Private Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let poster: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chart.bar.doc.horizontal.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let movie: UILabel = {
        let label = UILabel()
        label.text = "Название Фильма" // Если бы было в json брали бы оттуда
        label.font = UIFont(name: "Gill Sans Bold", size: 24)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hall: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Gill Sans Bold", size: 20)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateTime: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Gill Sans Bold", size: 20)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieState: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Gill Sans Bold", size: 20)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vipBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let vipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Gill Sans SemiBold", size: 18)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let comfortBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let comfortLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans SemiBold", size: 18)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let standartBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let standartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans SemiBold", size: 18)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let freePlaces: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Gill Sans Bold", size: 20)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(sessionInfo: SessionInfo, seatsType: [SeatType]) {
        self.dateTime.text = sessionInfo.date
        self.hall.text = sessionInfo.hall
        self.movieState.text = sessionInfo.movieState
        self.freePlaces.text = "Свободных мест: \(sessionInfo.freePlaces)"
        for type in seatsType {
            switch type.seatType {
            case "VIP": vipLabel.text = "\(type.name) - \(type.price)c."
            case "COMFORT": comfortLabel.text = "\(type.name) - \(type.price)c."
            case "STANDARD": standartLabel.text = "\(type.name) - \(type.price)c."
            default: ""
            }
        }
    }
    
    // MARK: - Private methods
    
    private func getLabelLength(_ label: UILabel) -> Double {
        let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        return size.width
    }
    
    private func setupView() {
        addSubview(scrollView)
        addSubview(poster)
        addSubview(movie)
        addSubview(dateTime)
        addSubview(hall)
        addSubview(vipBtn)
        addSubview(vipLabel)
        addSubview(comfortBtn)
        addSubview(comfortLabel)
        addSubview(standartBtn)
        addSubview(standartLabel)
        addSubview(movieState)
        addSubview(freePlaces)
        scrollView.addSubview(hallMapView)
        
        NSLayoutConstraint.activate([
            
            poster.topAnchor.constraint(equalTo: topAnchor),
            poster.bottomAnchor.constraint(equalTo: poster.topAnchor, constant: 200),
            poster.leadingAnchor.constraint(equalTo: leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: poster.leadingAnchor, constant: 160),
            
            movie.topAnchor.constraint(equalTo: poster.topAnchor, constant: 12),
            movie.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 20),
            movie.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            movie.bottomAnchor.constraint(equalTo: movie.topAnchor, constant: 24),
            
            hall.topAnchor.constraint(equalTo: movie.bottomAnchor, constant: 8),
            hall.leadingAnchor.constraint(equalTo: movie.leadingAnchor),
            hall.trailingAnchor.constraint(equalTo: movie.trailingAnchor),
            hall.bottomAnchor.constraint(equalTo: hall.topAnchor, constant: 28),
            
            dateTime.topAnchor.constraint(equalTo: hall.bottomAnchor, constant: 8),
            dateTime.leadingAnchor.constraint(equalTo: hall.leadingAnchor),
            dateTime.trailingAnchor.constraint(equalTo: hall.trailingAnchor),
            dateTime.bottomAnchor.constraint(equalTo: dateTime.topAnchor, constant: 32),
            
            movieState.topAnchor.constraint(equalTo: dateTime.bottomAnchor, constant: 8),
            movieState.leadingAnchor.constraint(equalTo: dateTime.leadingAnchor),
            movieState.trailingAnchor.constraint(equalTo: dateTime.trailingAnchor),
            movieState.bottomAnchor.constraint(equalTo: movieState.topAnchor, constant: 32),
            
            freePlaces.topAnchor.constraint(equalTo: movieState.bottomAnchor, constant: 8),
            freePlaces.leadingAnchor.constraint(equalTo: movieState.leadingAnchor),
            freePlaces.trailingAnchor.constraint(equalTo: movieState.trailingAnchor),
            freePlaces.bottomAnchor.constraint(equalTo: freePlaces.topAnchor, constant: 32),
            
            vipBtn.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 32),
            vipBtn.leadingAnchor.constraint(equalTo: poster.leadingAnchor, constant: 20),
            vipBtn.trailingAnchor.constraint(equalTo: vipBtn.leadingAnchor, constant: 24),
            vipBtn.bottomAnchor.constraint(equalTo: vipBtn.topAnchor, constant: 24),
            
            vipLabel.leadingAnchor.constraint(equalTo: vipBtn.trailingAnchor, constant: 12),
            vipLabel.trailingAnchor.constraint(equalTo: vipLabel.leadingAnchor, constant: 120),
            vipLabel.centerYAnchor.constraint(equalTo: vipBtn.centerYAnchor),
            
            comfortBtn.leadingAnchor.constraint(equalTo: vipLabel.trailingAnchor, constant: 32),
            comfortBtn.trailingAnchor.constraint(equalTo: comfortBtn.leadingAnchor, constant: 24),
            comfortBtn.bottomAnchor.constraint(equalTo: comfortBtn.topAnchor, constant: 24),
            comfortBtn.centerYAnchor.constraint(equalTo: vipBtn.centerYAnchor),
            
            comfortLabel.leadingAnchor.constraint(equalTo: comfortBtn.trailingAnchor, constant: 12),
            comfortLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            comfortLabel.centerYAnchor.constraint(equalTo: vipBtn.centerYAnchor),
            
            standartBtn.topAnchor.constraint(equalTo: vipBtn.bottomAnchor, constant: 12),
            standartBtn.leadingAnchor.constraint(equalTo: vipBtn.leadingAnchor),
            standartBtn.trailingAnchor.constraint(equalTo: standartBtn.leadingAnchor, constant: 24),
            standartBtn.bottomAnchor.constraint(equalTo: standartBtn.topAnchor, constant: 24),
            //            standartBtn.centerYAnchor.constraint(equalTo: vipBtn.centerYAnchor),
            
            standartLabel.leadingAnchor.constraint(equalTo: standartBtn.trailingAnchor, constant: 12),
            standartLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            standartLabel.centerYAnchor.constraint(equalTo: standartBtn.centerYAnchor),
            
            scrollView.topAnchor.constraint(equalTo: vipBtn.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            hallMapView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hallMapView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hallMapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hallMapView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hallMapView.widthAnchor.constraint(equalToConstant: 558), // Пока фиксируем размер, позже из JSON
            hallMapView.heightAnchor.constraint(equalToConstant: 346)
        ])
    }
}

extension HallView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return hallMapView
    }
}
