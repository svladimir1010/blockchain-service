// SPDX-License-Identifier: MIT
//— лицензия, разрешающая свободное использование кода

pragma solidity ^0.8.28; // Используемая версия компилятора Solidity

// Импорты из OpenZeppelin — безопасные, проверенные временем контракты
import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // Основной функционал NFT
import "@openzeppelin/contracts/access/Ownable.sol"; // Управление правами (только владелец может выполнять критические действия)

//import "@openzeppelin/contracts/utils/Counters.sol"; // Счётчик ID для NFT
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; // Хранение URI метаданных для каждого NFT

// Контракт NFT, который можно использовать для награждения пользователей (например, за выполнение задач)
contract TodoAchievementNFT is ERC721URIStorage, Ownable {
    //    using Counters for Counters.Counter;
    //    Counters.Counter private _tokenIdCounter; // Ведёт учёт количества созданных NFT

    uint256 private _tokenIdCounter; // Просто число, без OpenZeppelin Counters

    // Событие, которое поможет фронтенду узнавать, когда создан новый NFT
    event NftMinted(address indexed recipient, uint256 tokenId, string tokenURI);

    // Конструктор — вызывается один раз при создании контракта
    constructor()
    ERC721("TodoAchievementNFT", "TDONFT") // Устанавливаем имя и символ токена
    Ownable(msg.sender) // Устанавливаем того, кто задеплоил контракт, как владельца
    {}

    /**
     * Создаёт (mint) новый NFT и отправляет его на указанный адрес.
     * Может быть вызвана только владельцем контракта (например, вашим backend-сервером).
     *
     * @param to — адрес получателя NFT
     * @param tokenURI — ссылка на JSON-файл с метаданными (например, IPFS-ссылка на изображение и описание)
     * @return tokenId — ID нового NFT
     */
    function mintNft(address to, string memory tokenURI)
    public
        //Временно убрать onlyOwner для целей этого тестового задания.
    onlyOwner
    returns (uint256)
    {
        //        _tokenIdCounter.increment(); // Увеличиваем счётчик
        //        uint256 newItemId = _tokenIdCounter.current(); // Получаем новый ID

        _tokenIdCounter++;
        // Увеличиваем счётчик вручную
        uint256 newItemId = _tokenIdCounter;

        _mint(to, newItemId);
        // Создаём NFT
        _setTokenURI(newItemId, tokenURI);
        // Привязываем метаданные

        emit NftMinted(to, newItemId, tokenURI);
        // Сообщаем о выпуске нового NFT

        return newItemId;
    }

    // Получаем общее количество выпущенных NFT
    function getTotalMinted() public view returns (uint256) {
        //        return _tokenIdCounter.current();
        return _tokenIdCounter;
    }
}


