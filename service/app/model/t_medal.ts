/* indent size: 2 */

module.exports = app => {
  const DataTypes = app.Sequelize;

  const Model = app.model.define('t_medal', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    name: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    icon: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    grey_icon: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    description: {
      type: DataTypes.STRING(500),
      allowNull: true
    },
  }, {
    tableName: 't_medal',
    timestamps: false,
  });

  Model.associate = function () {

  }

  return Model;
};
