-- ============================================
-- Sistema de Controle de Locação
-- ConectaFácil Locações Tecnológicas
-- ============================================

CREATE DATABASE IF NOT EXISTS conectafacil CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE conectafacil;

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('admin', 'operador') NOT NULL DEFAULT 'operador',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de dispositivos
CREATE TABLE IF NOT EXISTS dispositivos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(100) NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,
    status ENUM('disponivel', 'alugado') NOT NULL DEFAULT 'disponivel',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de locações
CREATE TABLE IF NOT EXISTS locacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(150) NOT NULL,
    dispositivo_id INT NOT NULL,
    data_retirada DATE NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    data_devolucao DATE NULL,
    houve_dano TINYINT(1) NULL DEFAULT 0,
    valor_total DECIMAL(10,2) NULL,
    multa_atraso DECIMAL(10,2) NULL DEFAULT 0.00,
    taxa_dano DECIMAL(10,2) NULL DEFAULT 0.00,
    status ENUM('ativa', 'finalizada') NOT NULL DEFAULT 'ativa',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dispositivo_id) REFERENCES dispositivos(id)
);

-- Usuários do sistema (senhas em texto puro — sem criptografia)
INSERT INTO usuarios (nome, email, senha, perfil) VALUES
('Administrador',  'admin@conectafacil.com',      'admin123',      'admin'),
('Carlos Operador','operador@conectafacil.com',    'operador123',   'operador'),
('Ana Operadora',  'ana@conectafacil.com',         'ana123',        'operador'),
('Lucas Operador', 'lucas@conectafacil.com',       'lucas123',      'operador');

-- Dispositivos com preços atualizados
INSERT INTO dispositivos (modelo, marca, valor_diaria, status) VALUES
-- Smartphones premium
('iPhone 15 Pro Max',     'Apple',    180.00, 'disponivel'),
('iPhone 15',             'Apple',    130.00, 'disponivel'),
('iPhone 14 Pro',         'Apple',    110.00, 'alugado'),
('Galaxy S24 Ultra',      'Samsung',  160.00, 'alugado'),
('Galaxy S24',            'Samsung',  120.00, 'disponivel'),
('Galaxy S23 FE',         'Samsung',   85.00, 'disponivel'),
('Galaxy A55',            'Samsung',   60.00, 'disponivel'),
('Pixel 8 Pro',           'Google',   140.00, 'alugado'),
('Pixel 8',               'Google',   110.00, 'disponivel'),
('Moto Edge 50 Pro',      'Motorola',  90.00, 'disponivel'),
('Moto G85',              'Motorola',  55.00, 'disponivel'),
('Redmi Note 13 Pro',     'Xiaomi',    65.00, 'disponivel'),
('POCO X6 Pro',           'Xiaomi',    75.00, 'alugado'),
-- Tablets
('iPad Pro 13" M4',       'Apple',    250.00, 'disponivel'),
('iPad Air M2',           'Apple',    180.00, 'alugado'),
('iPad 10ª Geração',      'Apple',    120.00, 'disponivel'),
('Galaxy Tab S9 Ultra',   'Samsung',  220.00, 'disponivel'),
('Galaxy Tab S9 FE',      'Samsung',  110.00, 'disponivel'),
-- Notebooks
('MacBook Air M3',        'Apple',    350.00, 'disponivel'),
('MacBook Pro M3 Pro',    'Apple',    480.00, 'alugado'),
('Dell XPS 15',           'Dell',     320.00, 'disponivel'),
('ThinkPad X1 Carbon',    'Lenovo',   280.00, 'disponivel'),
('Surface Pro 10',        'Microsoft',300.00, 'disponivel'),
-- Acessórios / outros
('Apple Watch Ultra 2',   'Apple',     95.00, 'disponivel'),
('Galaxy Watch 7',        'Samsung',   70.00, 'disponivel'),
('AirPods Pro 2',         'Apple',     50.00, 'disponivel'),
('DJI Mini 4 Pro (drone)','DJI',      200.00, 'disponivel'),
('GoPro Hero 13',         'GoPro',    120.00, 'alugado');

-- Locações de exemplo (ativas)
INSERT INTO locacoes (nome_cliente, dispositivo_id, data_retirada, data_prevista_devolucao, status) VALUES
('João Silva',       3,  DATE_SUB(CURDATE(), INTERVAL 3 DAY),  DATE_ADD(CURDATE(), INTERVAL 4 DAY),  'ativa'),
('Maria Oliveira',   4,  DATE_SUB(CURDATE(), INTERVAL 1 DAY),  DATE_ADD(CURDATE(), INTERVAL 6 DAY),  'ativa'),
('Pedro Santos',     8,  DATE_SUB(CURDATE(), INTERVAL 5 DAY),  DATE_SUB(CURDATE(), INTERVAL 1 DAY),  'ativa'),
('Fernanda Lima',   13,  DATE_SUB(CURDATE(), INTERVAL 2 DAY),  DATE_ADD(CURDATE(), INTERVAL 5 DAY),  'ativa'),
('Rafael Costa',    15,  DATE_SUB(CURDATE(), INTERVAL 7 DAY),  DATE_SUB(CURDATE(), INTERVAL 2 DAY),  'ativa'),
('Camila Rocha',    20,  DATE_SUB(CURDATE(), INTERVAL 4 DAY),  DATE_ADD(CURDATE(), INTERVAL 3 DAY),  'ativa'),
('Bruno Alves',     28,  DATE_SUB(CURDATE(), INTERVAL 2 DAY),  DATE_ADD(CURDATE(), INTERVAL 5 DAY),  'ativa');

-- Locações finalizadas de exemplo
INSERT INTO locacoes (nome_cliente, dispositivo_id, data_retirada, data_prevista_devolucao, data_devolucao, houve_dano, valor_total, multa_atraso, taxa_dano, status) VALUES
('Thiago Mendes',    1,  DATE_SUB(CURDATE(), INTERVAL 15 DAY), DATE_SUB(CURDATE(), INTERVAL 10 DAY), DATE_SUB(CURDATE(), INTERVAL 10 DAY), 0,  900.00,   0.00,   0.00, 'finalizada'),
('Juliana Ferreira', 2,  DATE_SUB(CURDATE(), INTERVAL 12 DAY), DATE_SUB(CURDATE(), INTERVAL  8 DAY), DATE_SUB(CURDATE(), INTERVAL  7 DAY), 1,  670.00,  65.00, 150.00, 'finalizada'),
('Marcos Souza',     5,  DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 15 DAY), DATE_SUB(CURDATE(), INTERVAL 15 DAY), 0,  600.00,   0.00,   0.00, 'finalizada'),
('Patrícia Nunes',   6,  DATE_SUB(CURDATE(), INTERVAL 10 DAY), DATE_SUB(CURDATE(), INTERVAL  6 DAY), DATE_SUB(CURDATE(), INTERVAL  5 DAY), 0,  340.00,  42.50,   0.00, 'finalizada'),
('Diego Cardoso',    9,  DATE_SUB(CURDATE(), INTERVAL 30 DAY), DATE_SUB(CURDATE(), INTERVAL 25 DAY), DATE_SUB(CURDATE(), INTERVAL 25 DAY), 0,  550.00,   0.00,   0.00, 'finalizada'),
('Larissa Pinto',   10,  DATE_SUB(CURDATE(), INTERVAL  8 DAY), DATE_SUB(CURDATE(), INTERVAL  4 DAY), DATE_SUB(CURDATE(), INTERVAL  3 DAY), 1,  540.00,  45.00, 150.00, 'finalizada'),
('Gustavo Ramos',   11,  DATE_SUB(CURDATE(), INTERVAL 18 DAY), DATE_SUB(CURDATE(), INTERVAL 13 DAY), DATE_SUB(CURDATE(), INTERVAL 13 DAY), 0,  275.00,   0.00,   0.00, 'finalizada'),
('Isabela Torres',  12,  DATE_SUB(CURDATE(), INTERVAL 25 DAY), DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 19 DAY), 0,  390.00,  32.50,   0.00, 'finalizada');
