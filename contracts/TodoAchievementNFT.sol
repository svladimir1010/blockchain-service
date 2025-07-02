// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract TodoAchievementNFT is ERC721, ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;

    mapping(address => uint256) public completedTasks;
    mapping(address => uint256) public claimedTasksMilestone;
    uint256 public constant TASKS_PER_NFT = 10;

    event NftMinted(address indexed recipient, uint256 tokenId, string tokenURI);

    constructor()
    ERC721("TodoAchievementNFT", "TDONFT")
    Ownable(msg.sender)
    {}

    // ИСПРАВЛЕНИЕ: Явно переопределяем supportsInterface
    // ERC721URIStorage уже переопределяет supportsInterface из ERC721,
    // но если вы наследуете от обоих напрямую, вам нужно указать порядок наследования.
    // Здесь мы используем реализацию ERC721URIStorage, которая включает в себя ERC721.
    function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721, ERC721URIStorage) // Указываем, от каких базовых контрактов переопределяем
    returns (bool)
    {
        return super.supportsInterface(interfaceId); // Вызываем реализацию из базовых классов
    }

    // ИСПРАВЛЕНИЕ: Явно переопределяем tokenURI
    function tokenURI(uint256 tokenId)
    public
    view
    override(ERC721, ERC721URIStorage) // Указываем, от каких базовых контрактов переопределяем
    returns (string memory)
    {
        return super.tokenURI(tokenId); // Вызываем реализацию из базовых классов
    }


    function markTaskCompleted(address user) public onlyOwner {
        completedTasks[user]++;
    }


    // ИЗМЕНЕНИЕ ЗДЕСЬ: Добавляем параметр _recipient и делаем функцию onlyOwner
    function claimAchievementNFT(address _recipient) public onlyOwner {
        // Все проверки прогресса теперь будут для _recipient
        uint256 currentCompleted = completedTasks[_recipient];
        uint256 lastClaimedMilestone = claimedTasksMilestone[_recipient];

        uint256 newClaimableBlocks = (currentCompleted / TASKS_PER_NFT) - (lastClaimedMilestone / TASKS_PER_NFT);

        require(newClaimableBlocks > 0, "Not enough new tasks completed for NFT claim.");

        uint256 newMilestone = (currentCompleted / TASKS_PER_NFT) * TASKS_PER_NFT;

        require(newMilestone > lastClaimedMilestone, "No new claimable milestones reached.");

        for (uint256 i = 0; i < newClaimableBlocks; i++) {
            _tokenIdCounter++;
            uint256 newItemId = _tokenIdCounter;
            _safeMint(_recipient, newItemId); // Минтим NFT на _recipient
            emit NftMinted(_recipient, newItemId, "No URI set in claimAchievementNFT"); // Placeholder URI
        }

        claimedTasksMilestone[_recipient] = newMilestone; // Обновляем порог для _recipient
    }

    function mintNft(address to, string memory tokenURI)
    public
    onlyOwner
    returns (uint256)
    {
        _tokenIdCounter++;
        uint256 newItemId = _tokenIdCounter;

        _mint(to, newItemId);
        _setTokenURI(newItemId, tokenURI);

        emit NftMinted(to, newItemId, tokenURI);

        return newItemId;
    }

    function getTotalMinted() public view returns (uint256) {
        return _tokenIdCounter;
    }
}