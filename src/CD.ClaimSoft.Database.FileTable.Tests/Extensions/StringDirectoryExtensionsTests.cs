using CD.ClaimSoft.Database.FileTable.Extensions;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace CD.ClaimSoft.Database.FileTable.Tests.Extensions
{
    [TestClass]
    public class StringDirectoryExtensionsTests
    {
        public TestContext TestContext { get; set; }

        [TestMethod]
        [DataSource("Microsoft.VisualStudio.TestTools.DataSource.CSV", @"Data\GetRelativePathTestData.csv", "GetRelativePathTestData#csv", DataAccessMethod.Sequential)]
        public void RootIsNotIncluded()
        {
            // Arrange
            var root = TestContext.DataRow[0].ToString();
            var path = TestContext.DataRow[1].ToString();
            var expected = TestContext.DataRow[2].ToString();

            // Act
            var actual = path.GetRelativePath(root);

            // Assert
            Assert.AreEqual(expected, actual);

        }
    }
}
