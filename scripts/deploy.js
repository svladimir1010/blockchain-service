// scripts/deploy.js

async function main() {
  // Получаем контракт Factory для TodoAchievementNFT
  const TodoAchievementNFT = await ethers.getContractFactory("TodoAchievementNFT");

  // Развертываем контракт
  // deploy() отправляет транзакцию в блокчейн
  const todoAchievementNFT = await TodoAchievementNFT.deploy();

  // Ожидаем, пока контракт будет полностью развернут
  await todoAchievementNFT.waitForDeployment();

  // Выводим адрес развернутого контракта в консоль
  console.log(`TodoAchievementNFT развернут по адресу: ${todoAchievementNFT.target}`);

  // В реальном приложении вы сохранили бы этот адрес контракта
  // например, в файле или в переменных окружения для использования на бэкенде/фронтенде.
}

// Запускаем скрипт развертывания
main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
