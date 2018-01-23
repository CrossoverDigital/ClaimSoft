using System;
using System.IO;

using CD.ClaimSoft.Database.FileTable.Repository;

using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace CD.ClaimSoft.Database.FileTable.Tests.Repository
{
    [TestClass]
    public class FileTableRepositoryTests
    {
        public TestContext TestContext { get; set; }

        [TestMethod]
        [DataSource("Microsoft.VisualStudio.TestTools.DataSource.CSV", @"Data\IsTableRootData.csv", "IsTableRootData#csv", DataAccessMethod.Sequential)]
        public void IsTableRootTest()
        {
            // Arrange
            var server = @"\\Chuckzilla";
            var serverFQDN = @"\\Chuckzilla";
            var inst = "mssqlserver";
            var db = "cdTestDB";
            var table = "tdir";
            var tableRoot = Path.Combine(server, inst, db, table);
            var tableRootFqdn = Path.Combine(serverFQDN, inst, db, table);
            var repo = new FileTableRepository();

            var testDir = TestContext.DataRow[0].ToString();
            var expected = Convert.ToBoolean(TestContext.DataRow[1]);

            // Act
            var actual = repo.IsTableRoot(testDir, tableRoot, tableRootFqdn);

            // Assert
            Assert.AreEqual(expected, actual);
        }
    }
}
