# 🏆 Todo Achievement NFT Smart Contract

Этот проект реализует смарт-контракт стандарта **ERC-721** на языке **Solidity**. Контракт позволяет выпускать NFT-награды за достижения в приложении [My To-Do List](https://github.com/svladimir1010/my-todo-list).

Контракт развернут в тестовой сети **Sepolia** и используется в учебной интеграции с Web3, React и FastAPI.

---

## 🚀 Технологии

- **Solidity** — язык программирования для смарт-контрактов.
- **Hardhat** — среда для компиляции, тестирования и деплоя контрактов.
- **OpenZeppelin Contracts** — безопасные реализации стандартов (включая ERC-721).
- **ethers.js** — библиотека для взаимодействия с контрактами во фронтенде.

---

## 📄 Контракт: `TodoAchievementNFT.sol`

- **Имя коллекции:** `TodoAchievementNFT`
- **Символ токена:** `TDONFT`
- **Сеть:** Sepolia (Ethereum Testnet)

### 📌 Назначение

Контракт позволяет выпускать уникальные **NFT-награды** за достижения в приложении, например, за выполнение 10 задач.

---

## 🧩 Основные функции

| Функция | Описание |
|--------|----------|
| `constructor()` | Устанавливает имя и символ токена, сохраняет владельца контракта. |
| `mintNft(address to, string tokenURI)` | Минтит NFT на указанный адрес `to` с метаданными `tokenURI`. Только владелец контракта может вызывать. |
| `getTotalMinted()` | Возвращает общее число выпущенных токенов. |

---

## 📦 Развертывание

### ✅ Адрес контракта (Sepolia):

```
0xC367e0912cEB1238538f12cB07b7895e0817fCE5
```

> ⚠️ Примечание: этот адрес актуален для текущего деплоя. Если вы развернете контракт повторно, он изменится.

### 📚 Шаги для деплоя

1. Установите зависимости:
   ```bash
   npm install @openzeppelin/contracts dotenv @nomicfoundation/hardhat-toolbox
   ```

2. Создайте файл `.env` со следующими данными:
   ```
   SEPOLIA_RPC_URL=<ваш URL от Infura или Alchemy>
   PRIVATE_KEY=<приватный ключ от MetaMask (тестовый)>
   ```

3. Выполните компиляцию и деплой:
   ```bash
   npx hardhat compile
   npx hardhat run scripts/deploy.js --network sepolia
   ```

---

## 🔗 Интеграция с фронтендом

- Адрес контракта и его ABI (из `artifacts/contracts/TodoAchievementNFT.sol/TodoAchievementNFT.json`) импортируются во фронтенд.
- Используется в React-приложении для вызова `mintNft` через **ethers.js**.
- Пользователь подключает MetaMask, и при достижении 10 выполненных задач — получает NFT.

---

## 🌱 Возможности для улучшения

- ✅ Интеграция с IPFS или Pinata для хранения изображений и метаданных.
- 🛡️ Реализация проверки условий на бэкенде, где именно **сервер** вызывает `mintNft` (а не пользователь).
- 🧠 Добавление ролей, например: **pauseMinting()**, **админская панель**.
- 📈 Поддержка расширенного функционала NFT: уровни достижений, переносимость и т.п.

---

## 🔗 Полезные ссылки

- [Документация OpenZeppelin](https://docs.openzeppelin.com/contracts/)
- [Etherscan (контракт)](https://sepolia.etherscan.io/address/0xC367e0912cEB1238538f12cB07b7895e0817fCE5)
- [Hardhat](https://hardhat.org/)
- [MetaMask](https://metamask.io/)
- [Pinata (IPFS)](https://www.pinata.cloud/)
