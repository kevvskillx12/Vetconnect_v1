using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VetConnect_v1.Migrations
{
    /// <inheritdoc />
    public partial class AgregarTokenYEliminarTicket : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TicketsSoporte");

            migrationBuilder.DropColumn(
                name: "ClinicaId",
                table: "Usuarios");

            migrationBuilder.DropColumn(
                name: "Especialidad",
                table: "Usuarios");

            migrationBuilder.AlterColumn<int>(
                name: "HorarioAtencion",
                table: "Veterinarios",
                type: "int",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<int>(
                name: "Contacto",
                table: "Veterinarios",
                type: "int",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<string>(
                name: "VeterinarioId",
                table: "Veterinarios",
                type: "nvarchar(450)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .OldAnnotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AddColumn<string>(
                name: "TokenFCM",
                table: "Veterinarios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<int>(
                name: "Telefono",
                table: "Usuarios",
                type: "int",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AddColumn<string>(
                name: "VeterinarioId",
                table: "Usuarios",
                type: "nvarchar(450)",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "VeterinarioId",
                table: "Servicios",
                type: "nvarchar(450)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<decimal>(
                name: "Peso",
                table: "Mascotas",
                type: "decimal(5,2)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.AlterColumn<decimal>(
                name: "Longitud",
                table: "Geolocalizaciones",
                type: "decimal(9,6)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.AlterColumn<decimal>(
                name: "Latitud",
                table: "Geolocalizaciones",
                type: "decimal(9,6)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.AlterColumn<string>(
                name: "GeolocalizacionId",
                table: "Geolocalizaciones",
                type: "nvarchar(450)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .OldAnnotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AlterColumn<string>(
                name: "VeterinarioId",
                table: "Citas",
                type: "nvarchar(450)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.CreateIndex(
                name: "IX_Usuarios_VeterinarioId",
                table: "Usuarios",
                column: "VeterinarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Servicios_MascotaId",
                table: "Servicios",
                column: "MascotaId");

            migrationBuilder.CreateIndex(
                name: "IX_Servicios_VeterinarioId",
                table: "Servicios",
                column: "VeterinarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Mascotas_UsuarioId",
                table: "Mascotas",
                column: "UsuarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Configuraciones_UsuarioId",
                table: "Configuraciones",
                column: "UsuarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Citas_MascotaId",
                table: "Citas",
                column: "MascotaId");

            migrationBuilder.CreateIndex(
                name: "IX_Citas_UsuarioId",
                table: "Citas",
                column: "UsuarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Citas_VeterinarioId",
                table: "Citas",
                column: "VeterinarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Mascotas_MascotaId",
                table: "Citas",
                column: "MascotaId",
                principalTable: "Mascotas",
                principalColumn: "MascotaId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Usuarios_UsuarioId",
                table: "Citas",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Veterinarios_VeterinarioId",
                table: "Citas",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Configuraciones_Usuarios_UsuarioId",
                table: "Configuraciones",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Mascotas_Usuarios_UsuarioId",
                table: "Mascotas",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Servicios_Mascotas_MascotaId",
                table: "Servicios",
                column: "MascotaId",
                principalTable: "Mascotas",
                principalColumn: "MascotaId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Servicios_Veterinarios_VeterinarioId",
                table: "Servicios",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Usuarios_Veterinarios_VeterinarioId",
                table: "Usuarios",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Mascotas_MascotaId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Usuarios_UsuarioId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Veterinarios_VeterinarioId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Configuraciones_Usuarios_UsuarioId",
                table: "Configuraciones");

            migrationBuilder.DropForeignKey(
                name: "FK_Mascotas_Usuarios_UsuarioId",
                table: "Mascotas");

            migrationBuilder.DropForeignKey(
                name: "FK_Servicios_Mascotas_MascotaId",
                table: "Servicios");

            migrationBuilder.DropForeignKey(
                name: "FK_Servicios_Veterinarios_VeterinarioId",
                table: "Servicios");

            migrationBuilder.DropForeignKey(
                name: "FK_Usuarios_Veterinarios_VeterinarioId",
                table: "Usuarios");

            migrationBuilder.DropIndex(
                name: "IX_Usuarios_VeterinarioId",
                table: "Usuarios");

            migrationBuilder.DropIndex(
                name: "IX_Servicios_MascotaId",
                table: "Servicios");

            migrationBuilder.DropIndex(
                name: "IX_Servicios_VeterinarioId",
                table: "Servicios");

            migrationBuilder.DropIndex(
                name: "IX_Mascotas_UsuarioId",
                table: "Mascotas");

            migrationBuilder.DropIndex(
                name: "IX_Configuraciones_UsuarioId",
                table: "Configuraciones");

            migrationBuilder.DropIndex(
                name: "IX_Citas_MascotaId",
                table: "Citas");

            migrationBuilder.DropIndex(
                name: "IX_Citas_UsuarioId",
                table: "Citas");

            migrationBuilder.DropIndex(
                name: "IX_Citas_VeterinarioId",
                table: "Citas");

            migrationBuilder.DropColumn(
                name: "TokenFCM",
                table: "Veterinarios");

            migrationBuilder.DropColumn(
                name: "VeterinarioId",
                table: "Usuarios");

            migrationBuilder.AlterColumn<string>(
                name: "HorarioAtencion",
                table: "Veterinarios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Contacto",
                table: "Veterinarios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "VeterinarioId",
                table: "Veterinarios",
                type: "int",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)")
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AlterColumn<string>(
                name: "Telefono",
                table: "Usuarios",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "ClinicaId",
                table: "Usuarios",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Especialidad",
                table: "Usuarios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<int>(
                name: "VeterinarioId",
                table: "Servicios",
                type: "int",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.AlterColumn<decimal>(
                name: "Peso",
                table: "Mascotas",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(5,2)");

            migrationBuilder.AlterColumn<decimal>(
                name: "Longitud",
                table: "Geolocalizaciones",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(9,6)");

            migrationBuilder.AlterColumn<decimal>(
                name: "Latitud",
                table: "Geolocalizaciones",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(9,6)");

            migrationBuilder.AlterColumn<int>(
                name: "GeolocalizacionId",
                table: "Geolocalizaciones",
                type: "int",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)")
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AlterColumn<int>(
                name: "VeterinarioId",
                table: "Citas",
                type: "int",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.CreateTable(
                name: "TicketsSoporte",
                columns: table => new
                {
                    TicketId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Estado = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Mensaje = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Respuesta = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UsuarioId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TicketsSoporte", x => x.TicketId);
                });
        }
    }
}
