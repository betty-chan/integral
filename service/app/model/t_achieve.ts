/* indent size: 2 */

module.exports = app => {
  const DataTypes = app.Sequelize;

  const Model = app.model.define('t_achieve', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true
    },
    medal_id: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    user_id: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
  }, {
    tableName: 't_achieve',
    timestamps: false,
  });

  Model.associate = function () {

  }

  return Model;
};
