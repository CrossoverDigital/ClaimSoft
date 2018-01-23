using System.Data.SqlClient;
using System.Text;

using CD.ClaimSoft.Database.FileTable.Interfaces;
using CD.ClaimSoft.Database.FileTable.Managers;
using CD.ClaimSoft.Database.FileTable.Repository;
using Microsoft.VisualStudio.TestTools.UnitTesting;

using Moq;

namespace CD.ClaimSoft.Database.FileTable.Tests.Managers
{
    [TestClass]
    public class DirectoryManagerTests
    {

        public static string ByteArrayToString(byte[] ba)
        {
            StringBuilder hex = new StringBuilder(ba.Length * 2);
            foreach (byte b in ba)
                hex.AppendFormat("{0:X2}", b);
            return hex.ToString();
        }


        [TestMethod]
        public void CreateDirectoryTest()
        {
            // Arrange
            var table = "MyTable";
            var tableRoot = @"\MyTableDir";
            var dirStructure = @"dir1\dir2\dir3";
            var dirManager = new DirectoryManager();
            var fileTableRepository = new Mock<FileTableRepository>();
            fileTableRepository.Setup(m => m.FindPath(table, It.IsAny<string>(), true, It.IsAny<SqlConnection>())).Returns<string>(null);
            fileTableRepository.Setup(m => m.CreateDirectory(table, "dir1", It.IsAny<string>(), It.IsAny<SqlConnection>())).Returns("ABC12301");
            fileTableRepository.Setup(m => m.CreateDirectory(table, "dir2", It.IsAny<string>(), It.IsAny<SqlConnection>())).Returns("ABC12302");
            fileTableRepository.Setup(m => m.CreateDirectory(table, "dir3", It.IsAny<string>(), It.IsAny<SqlConnection>())).Returns("ABC12303");
            fileTableRepository.Setup(m => m.GetTableRootPath(table, 0, null)).Returns(tableRoot);
            dirManager.FileTableRepository = fileTableRepository.Object;

            // Act
            var pathId = dirManager.CreateDirectory(table, dirStructure, null);

            // Assert
            Assert.AreEqual("ABC12303", pathId);
        }

        [TestMethod]
        public void CreateDirectoryAlreadyExistsTest()
        {
            // Arrange
            var table = "MyTable";
            var tableRoot = @"\MyTableDir";
            var dirStructure = @"dir1\dir2\dir3";
            var dirManager = new DirectoryManager();
            var fileTableRepository = new Mock<FileTableRepository>();
            fileTableRepository.Setup(m => m.FindPath(table, dirStructure, true, It.IsAny<SqlConnection>())).Returns("ABC12303");
            fileTableRepository.Setup(m => m.GetTableRootPath(table, 0, null)).Returns(tableRoot);
            dirManager.FileTableRepository = fileTableRepository.Object;

            // Act
            var pathId = dirManager.CreateDirectory(table, dirStructure, null);

            // Assert
            Assert.AreEqual("ABC12303", pathId);
        }

        [TestMethod]
        public void DirectoryExistsNotFoundTest()
        {
            // Arrange
            var table = "MyTable";
            var tableRoot = @"\MyTableDir";
            var dirStructure = @"dir1\dir2\dir3";
            var dirManager = new DirectoryManager();
            var fileTableRepository = new Mock<FileTableRepository>();

            fileTableRepository.Setup(m => m.FindPath(table, It.IsAny<string>(), true, It.IsAny<SqlConnection>())).Returns<string>(null);
            dirManager.FileTableRepository = fileTableRepository.Object;

            fileTableRepository.Setup(m => m.FileTableExists(table, null)).Returns(true);
            fileTableRepository.Setup(m => m.GetTableRootPath(table, 0, null)).Returns(tableRoot);

            // Act
            var pathId = dirManager.DirectoryExists(table, dirStructure, null);

            // Assert
            Assert.IsNull(pathId);
        }

        [TestMethod]
        public void DirectoryExistsFoundTest()
        {
            // Arrange
            var table = "MyTable";
            var tableRoot = @"\MyTableDir";
            var dirStructure = @"dir1\dir2\dir3";
            var id = "12345679";
            var dirManager = new DirectoryManager();
            var fileTableRepo = new Mock<FileTableRepository>();
            fileTableRepo.Setup(m => m.FindPath(It.IsAny<string>(), It.IsAny<string>(), true, null)).Returns(id);
            dirManager.FileTableRepository = fileTableRepo.Object;

            var fileTableManagerMock = new Mock<IFileTableRepository>();
            fileTableManagerMock.Setup(m => m.FileTableExists(table, null)).Returns(true);
            fileTableManagerMock.Setup(m => m.GetTableRootPath(table, 0, null)).Returns(tableRoot);

            // Act
            var pathId = dirManager.DirectoryExists(table, dirStructure, null);

            // Assert
            Assert.AreEqual(id, pathId);
        }

        [TestMethod]
        public void FileExistsFoundTest()
        {
            // Arrange
            var table = "MyTable";
            var tableRoot = @"\MyTableDir";
            var dirStructure = @"dir1\dir2\file.txt";
            var id = "12345679";
            var dirManager = new DirectoryManager();

            var fileTableRepository = new Mock<FileTableRepository>();
            fileTableRepository.Setup(m => m.FindPath(It.IsAny<string>(), It.IsAny<string>(), false, null)).Returns(id);

            dirManager.FileTableRepository = fileTableRepository.Object;

            var fileTableManagerMock = new Mock<IFileTableRepository>();
            fileTableManagerMock.Setup(m => m.FileTableExists(table, null)).Returns(true);
            fileTableManagerMock.Setup(m => m.GetTableRootPath(table, 0, null)).Returns(tableRoot);

            // Act
            var pathId = dirManager.FileExists(table, dirStructure, null);

            // Assert
            Assert.AreEqual(id, pathId);
        }
    }
}
